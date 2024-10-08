Organização de Sub-redes: As sub-redes são separadas conforme o Microsoft Azure Well-Architected Framework, utilizando uma abordagem para segmentar diferentes tipos de serviços (Frontend, Backend, Data e Management).

VPC CIDR: A VNet está configurada com o CIDR 10.0.0.0/16 e cada sub-rede tem seu próprio intervalo conforme solicitado.

Futuras Melhorias: Poderia ser adicionado um Network Security Group (NSG) para cada sub-rede, com regras personalizadas, para melhorar a segurança.