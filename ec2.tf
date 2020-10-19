# Security Group
resource "aws_security_group" "app" {
  depends_on = [aws_vpc.vpc]
  vpc_id     = aws_vpc.vpc.id
  tags       = { Name = "${var.env}-${var.project}-app-sg" }
}

resource "aws_security_group_rule" "app_outbound_all" {
  depends_on        = [aws_security_group.app]
  security_group_id = aws_security_group.app.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "app_inbound_ssh" {
  depends_on        = [aws_security_group.app]
  security_group_id = aws_security_group.app.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "app_inbound_http" {
  depends_on               = [aws_security_group.app, aws_security_group.lb]
  security_group_id        = aws_security_group.app.id
  source_security_group_id = aws_security_group.lb.id # Allow access from load balancer
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  # cidr_blocks       = ["0.0.0.0/0"] # Allow all access
}

resource "aws_security_group_rule" "app_inbound_https" {
  depends_on               = [aws_security_group.app, aws_security_group.lb]
  security_group_id        = aws_security_group.app.id
  source_security_group_id = aws_security_group.lb.id # Allow access from load balancer
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  # cidr_blocks       = ["0.0.0.0/0"] # Allow all access
}

# EC2
resource "aws_instance" "ec2" {
  depends_on             = [aws_subnet.public_a, aws_security_group.app]
  vpc_security_group_ids = [aws_security_group.app.id]
  ami                    = "ami-09b86f9709b3c33d4" # Ubuntu
  # ami                    = "ami-0ce107ae7af2e92b5" # Amazon Linux 2
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_a.id
  key_name      = var.key_pair
  tags          = { Name = "${var.env}-${var.project}-app-ec2" }
}
