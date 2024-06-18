FROM centos:latest

RUN yum update -y && \
    yum install -y vsftpd && \
    yum clean all

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 20 21

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
