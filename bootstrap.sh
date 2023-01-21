sudo yum update
sudo mkdir -p /var/www/html/
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-02af6e25c499e6cdb.efs.us-east-1.amazonaws.com:/ /var/www/html/
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
cd /home/ec2-user/
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz