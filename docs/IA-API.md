## Documentação da API  

A documentação completa da API do **Shaped** pode ser acessada nos seguintes links:  

- **Ambiente de Staging**: [DOC](https://api.ia.staging.shaped.com.br/redoc/)
- **Ambiente de Produção**: [DOC](https://api.ia.shaped.com.br/redoc/)

### Webhook de Processamento  

A API do Shaped permite a configuração de um **webhook** para recebimento dos dados de avaliação. Esse webhook pode ser definido no backend do cliente e deve ser enviado para API do Shaped através do parâmetro `webhook_url` .  

Quando configurado, a API de IA do Shaped enviará os dados processados para o endpoint informado, retornando os seguintes campos:  

- **`content`**: Contém todos os dados da avaliação em formato de string. Esse formato é útil para sistemas que utilizam processamento baseado em texto, como o Discord.  
- **`measurement`**: Contém os dados da avaliação estruturados em formato JSON, permitindo integração mais flexível e estruturada com outros sistemas.  

A escolha entre os formatos `content` e `measurement` permite que diferentes plataformas integrem a API de acordo com suas necessidades específicas.  

### Explicação dos campos usados
A tabela abaixo apresenta um conjunto de variáveis utilizadas para avaliação da composição corporal e da distribuição de gordura em indivíduos. Neste caso, utilizamos a tabela para explicar o que representa cada campo retornado pela nossa API, facilitando a interpretação dos dados gerados automaticamente a partir de medições corporais.
| **Descrição**             | **Variável**          |
| ------------------------- | --------------------- |
| Índice de conicidade      | `ic_index`            |
| Razão Cintura-Quadril     | `waist_hip`           |
| Razão Cintura-Estatura    | `waist_height`        |
| Circunferência do quadril | `hip`                 |
| Circunferência da cintura | `waist`               |
| Fat Mass Index - FMI      | `fat_mass_index_bia`  |
| Lean Mass Index - LMI     | `lean_mass_index_bia` |
| Percentual de gordura     | `bia`                 |
