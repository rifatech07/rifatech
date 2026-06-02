-- Configurações da rifa (WhatsApp, prêmio, data) — rode no SQL Editor

CREATE TABLE IF NOT EXISTS rifa_config (
  id INT PRIMARY KEY DEFAULT 1 CHECK (id = 1),
  whatsapp TEXT NOT NULL DEFAULT '5531982635834',
  premio TEXT NOT NULL DEFAULT 'Caixa de Som JBL',
  data_sorteio TEXT NOT NULL DEFAULT '30/06/2026',
  updated_at TIMESTAMPTZ DEFAULT now()
);

INSERT INTO rifa_config (id, whatsapp, premio, data_sorteio)
VALUES (1, '5531982635834', 'Caixa de Som JBL', '30/06/2026')
ON CONFLICT (id) DO NOTHING;

ALTER TABLE rifa_config ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS rifa_config_public_read ON rifa_config;
CREATE POLICY rifa_config_public_read ON rifa_config
  FOR SELECT TO anon, authenticated
  USING (true);

DROP POLICY IF EXISTS rifa_config_admin_update ON rifa_config;
CREATE POLICY rifa_config_admin_update ON rifa_config
  FOR UPDATE TO authenticated
  USING (true)
  WITH CHECK (true);

GRANT SELECT ON TABLE public.rifa_config TO anon, authenticated;
GRANT UPDATE ON TABLE public.rifa_config TO authenticated;

NOTIFY pgrst, 'reload schema';
