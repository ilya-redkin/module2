output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.wp_alb.dns_name
}