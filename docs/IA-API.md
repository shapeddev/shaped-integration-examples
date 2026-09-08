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
A tabela abaixo apresenta a descrição de cada campo retornado pela nossa API, facilitando a interpretação dos dados gerados automaticamente a partir de medições corporais.
| Field | Description |
|---|---|
| `process_id` | Unique identifier of the measurement record, used to check status and match webhook deliveries. |
| `status` | Current state of the processing job: `"created"`, `"processing"`, `"succeed"`, or `"failed"`. |
| `error` | Description of the failure, if the job failed. `null` otherwise. |
| `duration_seconds` | Total processing time, in seconds. |
| `finished_at` | Timestamp of when processing completed. Only set on success. |
| `webhook_url` | Callback URL for delivering the result. Optional. |
| `metadata` | Custom free-form text attached to the request. Optional. |
| `sex` | Biological sex: `"male"` or `"female"`. Required. |
| `age` | Age, in years. Required (18–80). |
| `weight_kg` | Body weight, in kilograms. Required (40–210 kg). |
| `height_cm` | Height, in centimeters. Required (59–250 cm). |
| ❌ `dxa` ❌ | 🚨 **DEPRECATED DO NOT USE.** |
| `bia` | Body fat percentage estimated via Bioelectrical Impedance Analysis (BIA), in %. |
| `biceps` | Biceps circumference, in cm. |
| `forearm` | Forearm circumference, in cm. |
| `waist` | Waist circumference, in cm. |
| `hip` | Hip circumference, in cm. |
| `thigh` | Thigh circumference, in cm. |
| `calf` | Calf circumference, in cm. |
| `waist_height` | Waist-to-height ratio, unitless. |
| `waist_hip` | Waist-to-hip ratio, unitless. |
| `ic_index` | Conicity index, unitless. Indicates how "cone-shaped" the body is, as a proxy for central/abdominal fat distribution. |
| `fat_mass_bia` | Absolute body fat mass estimated, in kg. |
| `fat_mass_index_bia` | Fat Mass Index (FMI) estimated, in kg/m². |
| `lean_mass_bia` | Absolute lean (fat-free) body mass estimated, in kg. |
| `lean_mass_index_bia` | Lean Mass Index (LMI/FFMI) estimated, in kg/m². |
| `water_bia` | Estimated total body water, in kg. |
| `tmb_bia` | Basal metabolic rate estimated, in kcal/day. |
