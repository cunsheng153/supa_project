-- 创建 users 表
CREATE TABLE IF NOT EXISTS users (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  phone TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  deleted_at TIMESTAMP WITH TIME ZONE
);

-- 为测试目的，可以暂时禁用 RLS（生产环境请设置适当的策略）
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- 允许所有操作（仅用于测试，生产环境请设置更严格的策略）
CREATE POLICY "Allow all operations for testing" ON users
  FOR ALL
  USING (true)
  WITH CHECK (true);

-- 或者，如果你想使用更安全的策略，可以使用以下策略：
-- CREATE POLICY "Allow public read access" ON users
--   FOR SELECT
--   USING (true);
--
-- CREATE POLICY "Allow public insert" ON users
--   FOR INSERT
--   WITH CHECK (true);
--
-- CREATE POLICY "Allow public update" ON users
--   FOR UPDATE
--   USING (true)
--   WITH CHECK (true);
--
-- CREATE POLICY "Allow public delete" ON users
--   FOR DELETE
--   USING (true);

