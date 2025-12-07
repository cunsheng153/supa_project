-- 迁移脚本：为现有 users 表添加 deleted_at 字段（虚拟删除支持）
-- 如果表已存在但没有 deleted_at 字段，运行此脚本

-- 添加 deleted_at 字段
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMP WITH TIME ZONE;

-- 为 deleted_at 字段创建索引以提高查询性能
CREATE INDEX IF NOT EXISTS idx_users_deleted_at ON users(deleted_at);

-- 添加注释说明
COMMENT ON COLUMN users.deleted_at IS '虚拟删除时间戳，NULL 表示未删除';

