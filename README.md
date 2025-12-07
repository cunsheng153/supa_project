# 用户管理系统

基于 Next.js、Supabase 和 Tailwind CSS 构建的简单用户管理系统。

## 功能特性

- ✅ 用户列表展示
- ✅ 添加新用户
- ✅ 编辑用户信息
- ✅ 虚拟删除用户（软删除，保留原始数据）
- ✅ 现代化的 UI 设计（Tailwind CSS）

## 技术栈

- **前端框架**: Next.js 14 (App Router)
- **样式**: Tailwind CSS
- **数据库**: Supabase
- **语言**: TypeScript

## 开始使用

### 1. 安装依赖

```bash
npm install
```

### 2. 配置 Supabase

1. 在 [Supabase](https://supabase.com) 创建一个新项目
2. 在 Supabase Dashboard 的 SQL Editor 中运行 `supabase_setup.sql` 文件来创建 `users` 表和 RLS 策略
   
   **如果表已存在但没有 `deleted_at` 字段**，请运行 `supabase_migration_add_deleted_at.sql` 迁移脚本。
   
   或者手动创建表：

```sql
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  phone TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  deleted_at TIMESTAMP WITH TIME ZONE
);
```

3. 复制 `env.example` 为 `.env.local`：

```bash
cp .env.example .env.local
```

4. 在 `.env.local` 中填入你的 Supabase 项目信息：
   - `NEXT_PUBLIC_SUPABASE_URL`: 你的 Supabase 项目 URL
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`: 你的 Supabase Anon Key

你可以在 Supabase Dashboard 的 Settings > API 页面找到这些信息。

### 3. 运行开发服务器

```bash
npm run dev
```

打开 [http://localhost:3000](http://localhost:3000) 查看应用。

## 项目结构

```
supabase_project/
├── app/
│   ├── globals.css      # 全局样式
│   ├── layout.tsx       # 根布局
│   └── page.tsx         # 主页面
├── components/
│   ├── UserForm.tsx     # 用户表单组件
│   └── UserTable.tsx    # 用户表格组件
├── lib/
│   └── supabase.ts      # Supabase 客户端配置
├── package.json
├── tsconfig.json
├── tailwind.config.js
├── supabase_setup.sql              # 数据库初始化 SQL
├── supabase_migration_add_deleted_at.sql  # 添加虚拟删除字段的迁移脚本
├── env.example          # 环境变量示例
└── README.md
```

## 构建生产版本

```bash
npm run build
npm start
```

## 虚拟删除功能

系统使用虚拟删除（软删除）机制：
- 删除用户时，不会真正删除数据库记录
- 而是将 `deleted_at` 字段设置为当前时间戳
- 查询用户列表时，自动过滤掉已删除的用户（`deleted_at IS NULL`）
- 这样可以保留历史数据，便于数据恢复和审计

## 注意事项

- 确保 Supabase 项目已正确配置 Row Level Security (RLS) 策略，或者暂时禁用 RLS 进行测试
- 生产环境中请确保设置适当的 RLS 策略以保证数据安全
- 如果已有用户表但没有 `deleted_at` 字段，请运行迁移脚本 `supabase_migration_add_deleted_at.sql`

