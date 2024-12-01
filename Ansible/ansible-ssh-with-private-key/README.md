## Connecting Ansible Server to Machines via SSH Private Key

This guide explains how to connect an Ansible server to machines using SSH private key authentication.

### Steps:

1. Place the SSH private key on the Ansible server machine:
   - If you don't have an SSH private key, you can generate one using the command `ssh-keygen` on your Ansible server machine.
   - In the directory /root/.ssh/, a file named id_rsa has been created, which is your private key.

2. Ensure the private key has the correct permissions:
   - Set the correct permissions for the private key file: `chmod 600 ~/.ssh/id_rsa`

3. Copy the public key to the Ansible server:
   - If you generated the SSH key pair on the Ansible server, the public key is usually located in the same directory as the private key. It is typically named id_rsa.pub.
   - Please copy the content inside the id_rsa.pub file on the server and paste it into the authorized_keys file on the destination machine.
   OR
   - ssh-copy-id root@destinationip
     
4. Log in to the destination machine through the ansible server :
   - Use your preferred method to log in to the destination machine using SSH. You can use the command ssh username@destination_ip .
   - If the connection is successful, you should see a "SUCCESS" message.

By following these steps, you should be able to connect to machines from your Ansible server using an SSH private key.
