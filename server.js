// ═══════════════════════════════════════════════════════════════
//  随手 后端服务
//  用法: node server.js
//  功能: 提供静态文件服务 + 数据读写 API
//  依赖: 无（全部使用 Node.js 内置模块）
// ═══════════════════════════════════════════════════════════════

// ── 引入内置模块 ──
// http:  创建 HTTP 服务器，处理网络请求
// fs:    File System，读写文件
// path:  处理文件路径（自动适配 Windows/Mac/Linux 的路径分隔符）
const http = require('http');
const fs = require('fs');
const path = require('path');

// ── 配置 ──
const PORT = 3000;  // 服务器端口，浏览器访问 http://localhost:3000
// 数据文件的完整路径：__dirname 表示当前文件所在目录
// path.join 会自动处理斜杠：Windows 用 \，Mac/Linux 用 /
const DATA_FILE = path.join(__dirname, 'todo-data.json');

// ── 确保数据文件存在 ──
// fs.existsSync() 检查文件是否存在
// 如果不存在就创建一个，写入默认的空数据结构
if (!fs.existsSync(DATA_FILE)) {
  const defaultData = {
    tasks: [],    // 任务列表
    order: [],    // 任务排序（存储任务 ID 的数组）
    date: null,   // 上次访问日期（用于每日重置）
    collapse: false // 已完成任务是否折叠
  };
  // JSON.stringify(data, null, 2) 的第三个参数 2 表示缩进 2 空格，方便人类阅读
  fs.writeFileSync(DATA_FILE, JSON.stringify(defaultData, null, 2));
}

// ── MIME 类型映射 ──
// 浏览器需要知道文件类型才能正确显示
// MIME (Multipurpose Internet Mail Extensions) 是文件类型的标准名称
// 比如 .html 对应 text/html，浏览器就知道要渲染成网页
const MIME = {
  '.html': 'text/html; charset=utf-8',       // 网页
  '.css':  'text/css; charset=utf-8',        // 样式表
  '.js':   'application/javascript; charset=utf-8', // JavaScript
  '.json': 'application/json; charset=utf-8', // JSON 数据
  '.svg':  'image/svg+xml',                   // SVG 矢量图
  '.png':  'image/png',                       // PNG 图片
  '.ico':  'image/x-icon'                     // 网站图标
};

// ── 创建 HTTP 服务器 ──
// http.createServer() 接收一个回调函数
// 每当有请求进来（浏览器访问、点击按钮等），都会执行这个函数
// req = request（请求对象）：包含请求地址、方法、头信息等
// res = response（响应对象）：用来给浏览器返回数据
const server = http.createServer((req, res) => {

  // ── CORS 跨域设置 ──
  // CORS (Cross-Origin Resource Sharing) 跨域资源共享
  // 浏览器安全策略默认禁止网页访问不同地址的资源
  // 设置这些头信息告诉浏览器："我允许你访问我"
  // '*' 表示允许所有来源访问（本地开发用，生产环境应该限制域名）
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  // ── 处理预检请求 ──
  // 浏览器在发送 POST 请求前，会先发一个 OPTIONS 请求来"试探"
  // 这叫做"预检请求"（Preflight Request）
  // 返回 204（No Content）表示"我支持这些方法，你可以发请求了"
  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    return res.end();
  }

  // ════════════════════════════════════════
  //  API 路由：读取数据
  //  GET /api/data → 返回 todo-data.json 的内容
  // ════════════════════════════════════════
  if (req.method === 'GET' && req.url === '/api/data') {
    try {
      // 同步读取文件（小文件用同步没问题，大文件应该用异步）
      const data = fs.readFileSync(DATA_FILE, 'utf-8');
      // 设置响应头，告诉浏览器返回的是 JSON 格式
      res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
      return res.end(data);  // 把文件内容返回给浏览器
    } catch (e) {
      // 文件读取失败（可能被删除或权限不足）
      res.writeHead(500, { 'Content-Type': 'application/json' });
      return res.end(JSON.stringify({ error: 'Failed to read data' }));
    }
  }

  // ════════════════════════════════════════
  //  API 路由：写入数据
  //  POST /api/data → 将请求体的数据写入 todo-data.json
  // ════════════════════════════════════════
  if (req.method === 'POST' && req.url === '/api/data') {
    // POST 请求的数据在请求体（body）里，需要分块接收
    // 因为数据可能很大，不能一次性全部加载到内存
    let body = '';

    // 'data' 事件：每收到一块数据就触发一次
    // chunk 是一块数据片段（Buffer 类型，+ 自动转成字符串）
    req.on('data', chunk => { body += chunk; });

    // 'end' 事件：所有数据接收完毕
    req.on('end', () => {
      try {
        // 把 JSON 字符串解析成 JavaScript 对象
        const data = JSON.parse(body);

        // 格式化写入文件（null, 2 = 缩进 2 空格，方便人类阅读）
        fs.writeFileSync(DATA_FILE, JSON.stringify(data, null, 2), 'utf-8');

        // 返回成功响应
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ ok: true }));
      } catch (e) {
        // JSON 解析失败（前端传了非法数据）
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Invalid JSON' }));
      }
    });

    // 注意：这里 return 但没有 res.end()
    // 因为响应要等数据接收完毕后才发送（在 req.on('end') 里）
    return;
  }

  // ════════════════════════════════════════
  //  静态文件服务：返回 HTML/CSS/JS/图片等文件
  // ════════════════════════════════════════

  // 处理根路径：/ → 返回 /todo.html（首页）
  let filePath = req.url === '/' ? '/todo.html' : req.url;

  // 拼接完整路径：__dirname + 请求路径
  // 比如请求 /favicon.svg → E:\project\todo-list\favicon.svg
  filePath = path.join(__dirname, filePath);

  // ── 安全检查：防止目录遍历攻击 ──
  // 恶意用户可能请求 ../../etc/passwd 来读取系统文件
  // 检查拼接后的路径是否还在项目目录内
  // 如果不包含 __dirname，说明被"逃"出去了，拒绝访问
  if (!filePath.startsWith(__dirname)) {
    res.writeHead(403);  // 403 = Forbidden（禁止访问）
    return res.end('Forbidden');
  }

  // 获取文件扩展名，查找对应的 MIME 类型
  const ext = path.extname(filePath).toLowerCase();
  const contentType = MIME[ext] || 'application/octet-stream';
  // 'application/octet-stream' 是兜底类型，表示"不知道是什么，下载吧"

  // 异步读取文件（非阻塞，不卡住其他请求）
  fs.readFile(filePath, (err, content) => {
    if (err) {
      if (err.code === 'ENOENT') {
        // ENOENT = Error NO ENTry，文件不存在
        res.writeHead(404);
        res.end('Not Found');
      } else {
        // 其他错误（权限问题等）
        res.writeHead(500);
        res.end('Server Error');
      }
    } else {
      // 读取成功，返回文件内容
      res.writeHead(200, { 'Content-Type': contentType });
      res.end(content);
    }
  });
});

// ── 启动服务器，监听指定端口 ──
// 当服务器成功启动后，回调函数会执行，打印启动信息
server.listen(PORT, () => {
  console.log(`\n  随手 running at http://localhost:${PORT}\n`);
  console.log(`  Data file: ${DATA_FILE}\n`);
  console.log('  Press Ctrl+C to stop.\n');
});
