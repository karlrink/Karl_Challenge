
SRE Challenge

•	Express everything in code.

This means IaC.  Terraform For Infrastucture as Code.

•	Create and deploy a running instance of a web server    

terraform/aws/single-instance(terraform/aws/single-instance)    


1. terraform init
2. terraform validate
3. terraform plan
4. terraform apply

---

http://<aws.instance.ip>:80/

http is redirected to https  

https://<aws.instance.ip>:443/

---

5. terraform destroy


•   Secure this application and host such that only appropriate ports are publicly exposed and any http requests are redirected to https.  

For http I have set the nginx.conf to redirect plain text http 80 to https 443 with the self signed cert.  For ssh I have turned off the ssh service.

•   Develop and apply automated tests to validate the correctness of the server configuration.

For a quick sanity check, you can use the curl command from any terminal to get the http urls.  You can verify the self signed ssl cert via the openssl command.  I created a bash script here terraform/aws/single-instance/verify_correctness.sh(terraform/aws/single-instance/verify_correctness.sh)  
The plain text http port 80 will return a 301
```
$ curl http://<aws.instance.ip>:80/ 
<html>
<head><title>301 Moved Permanently</title></head>
<body>
<center><h1>301 Moved Permanently</h1></center>
<hr><center>nginx/1.16.1</center>
</body>
</html>
```

The https port 443 will return the index.html content  
```
$ curl -k https://<aws.instance.ip>:443/
<html>
<head>
<title>Hello World</title>
</head>
<body>
<h1>Hello World!</h1>
</body>
</html>
```

Use openssl command to verify 
```
$ openssl s_client -connect  <aws.instance.ip>:443  
CONNECTED(00000003)
depth=0 C = CA, ST = QC, O = "Company, Inc.", CN = mydomain.com

```

Use the ssh command to verify that ssh is off
```
$ ssh ec2-user@<aws.instance.ip>
ssh: connect to host <aws.instance.ip> port 22: Connection refused
```

This demonstrates the use of infrastructure as code to spin up a running instance of a web server, secure the host such that only appropriate ports are publicly exposed and any http requests are redirected to https.

•   think about how you would architect a scalable and secure static web application in AWS.

For static content, you can deploy to a Content Delivery Network.  Using Amazon CloudFront technology you can create a distribution for CDN delivery and management.  Newer technology architectures like JAMStack (JavaScript, API, Markup) https://en.wikipedia.org/wiki/Jamstack can deploy directly to CDN via Git repository.  A scalable and secure solution is to host the content via AWS S3 bucket.







