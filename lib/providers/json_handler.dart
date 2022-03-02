// TODO: Criar toda a lógica de processamento da mensagem JSON: info, configs e readings
// TODO: Atualizar os providers com as informações recebidas
void processJsonInfo(Map<String, dynamic> json) {
  if (!json.containsKey("info")) return;
}

void processJsonConfig(Map<String, dynamic> json) {
  if (!json.containsKey("configs")) return;
}

void processJsonTeletry(Map<String, dynamic> json) {
  if (!json.containsKey("telemetry")) return;
}
