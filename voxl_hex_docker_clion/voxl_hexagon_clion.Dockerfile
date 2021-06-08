FROM voxl-hexagon

########################################################################
#setup for clion dev
RUN ( \
   echo 'LogLevel DEBUG2'; \
   echo 'PermitRootLogin yes'; \
   echo 'PasswordAuthentication yes'; \
   echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
 ) > /etc/ssh/sshd_config_clion \
 && mkdir /run/sshd

RUN apt update
RUN apt  install -y gdb clang rsync openssh-server
RUN echo "root:root" | chpasswd 

CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_clion"]