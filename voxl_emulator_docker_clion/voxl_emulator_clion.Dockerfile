FROM voxl-emulator:V1.5

COPY libpopt0_1.16-r3_aarch64.ipk .
COPY rsync_3.1.1-r0_aarch64.ipk .
COPY openssh-sftp-server_7.1p2-r0_aarch64.ipk . 

RUN opkg install libpopt0_1.16-r3_aarch64.ipk
RUN opkg install rsync_3.1.1-r0_aarch64.ipk
RUN opkg install openssh-sftp-server_7.1p2-r0_aarch64.ipk


#setup for clion dev
RUN ( \
   echo 'LogLevel DEBUG2'; \
   echo 'PermitRootLogin yes'; \
   echo 'PasswordAuthentication yes'; \
   echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
 ) > /etc/ssh/sshd_config_clion \
 && mkdir /run/sshd

 RUN (\
        echo 'Match User root';   \                                                             
        echo -e '\tChrootDirectory /'; \                                          
        echo -e '\tX11Forwarding no';  \                                           
        echo -e '\tAllowTcpForwarding no'; \                                      
        echo -e '\tForceCommand internal-sftp';) >> /etc/ssh/sshd_config_clion 

RUN ssh-keygen -A

#CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_clion"]