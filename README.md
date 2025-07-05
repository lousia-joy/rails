a real-time instagram topics wall
静态版本的话题墙。
一个尝试构建的 Ruby on Rails 项目，目标是实现不刷新页面即可实时展示带有指定标签的 Instagram 帖子（比如 #catlife）。

🧠 项目目标
原本希望实现以下功能：
输入一个 Instagram 标签（如 #cat），后端实时从 API 获取该标签下的最新帖子。

前端展示图文信息，用户体验类似瀑布流，项目无需刷新页面即可展示新增内容。

🧱 项目结构与阶段进度
前端页面结构	✅ 初步完成	使用 ERB 模板展示数据

模拟数据读取	✅ 完成	成功通过 JSON 文件加载本地帖子数据

自定义 Model	✅ 完成	Topic 和 Post 均为自定义 Ruby 类（非 ActiveRecord）

控制器逻辑	✅ 可运行	通过 TopicsController 加载展示页面

数据存储方式	❌ 未迁移	未使用数据库，导致无法动态更新数据

实时更新机制	❌ 未实现	未接入真实 API，且未构建轮询或 WebSocket 等实时机制

数据持久化	❌ 阻塞中	尝试引入 ActiveRecord 模型失败，原因见下文

🛑 失败原因
本项目终止的直接原因如下：

项目初始化环境存在缺陷

原始项目未启用数据库支持（可能未执行 rails new my_app -d postgresql）

post和topic设置为普通Ruby类，使用api预先获得和处理了posts数据，保存为json格式。

尝试运行 rails db:migrate 报错：“Unrecognized command”

结构设计与后续需求冲突

一开始仅打算读取本地 JSON 文件 ➜ 所以未使用 ActiveRecord，但后续希望实现“实时 API 获取、展示最新帖子”，需要数据表支持 ➜ 架构不匹配

使用的 devcontainer 模板未启用数据库，导致数据库相关命令失效

GitHub Codespaces 中未配置数据库容器，操作受限

📌 学习收获
初步掌握 Rails 中 model-view-controller (MVC) 的结构搭建方式

熟悉自定义类与 JSON 数据解析

理解 ActiveRecord 的优势与适用场景

明白项目一开始选择架构方向的重要性：临时方案不一定适合未来扩展

api：https://rapidapi.com/irrors-apis/api/instagram-looter2
![image](https://github.com/user-attachments/assets/4c5b5844-691d-48f9-b693-d6a374c0847c)
![image](https://github.com/user-attachments/assets/d39bc3c8-87c6-4c16-986e-c334169b4e34)
![image](https://github.com/user-attachments/assets/dc7ed4e0-058a-4718-9d9c-1f3e0b54cdb3)

最后模拟广播失败，还是要用ActiveRecord更方便实时处理。
