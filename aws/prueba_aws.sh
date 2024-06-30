
AMI_ID="ami-0abcdef1234567890"  
INSTANCE_TYPE="t2.micro"
KEY_NAME="mi-clave-ec2" 
SECURITY_GROUP="mi-grupo-seguridad" 

INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURITY_GROUP \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "Instancia EC2 creada con ID: $INSTANCE_ID"


aws ec2 wait instance-running --instance-ids $INSTANCE_ID

echo "La instancia EC2 está en estado 'running'"


aws ec2-instance-connect send-ssh-public-key \
    --instance-id $INSTANCE_ID \
    --availability-zone $(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].Placement.AvailabilityZone' --output text) \
    --instance-os-user ec2-user \
    --ssh-public-key file://~/.ssh/id_rsa.pub

ssh -o "StrictHostKeyChecking=no" ec2-user@$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text) << 'EOF'
sudo yum update -y
EOF

echo "Comando ejecutado en la instancia EC2"
