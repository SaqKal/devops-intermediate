resource "aws_route_table_association" "jenkins" {
  subnet_id      = aws_subnet.jenkins.id
  route_table_id = aws_vpc.my_vpc.default_route_table_id
}

resource "aws_route_table_association" "jenkins_worker" {
  subnet_id      = aws_subnet.jenkins_worker.id
  route_table_id = aws_vpc.my_vpc.default_route_table_id
}
resource "aws_route_table_association" "asg_elb_1" {
  subnet_id      = aws_subnet.asg_elb_1.id
  route_table_id = aws_vpc.my_vpc.default_route_table_id
}

resource "aws_route_table_association" "asg_elb_2" {
  subnet_id      = aws_subnet.asg_elb_2.id
  route_table_id = aws_vpc.my_vpc.default_route_table_id
}
