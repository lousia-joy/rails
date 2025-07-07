a real-time instagram topics wall
静态版本的话题墙。
一个尝试构建的 Ruby on Rails 项目，目标是实现不刷新页面即可实时展示带有指定标签的 Instagram 帖子（比如 #catlife）。


原本希望实现以下功能：
输入一个 Instagram 标签（如 #cat），后端实时从 API 获取该标签下的最新帖子。
前端展示图文信息，用户体验类似瀑布流，项目无需刷新页面即可展示新增内容。

结构设计与后续需求冲突
一开始仅打算读取本地 JSON 文件 ➜ 所以未使用 ActiveRecord，但后续希望实现“实时 API 获取、展示最新帖子”，需要数据表支持 ➜ 架构不匹配
使用的 devcontainer 模板未启用数据库，导致数据库相关命令失效
GitHub Codespaces 中未配置数据库容器，操作受限

我明白项目一开始选择架构方向的重要性：临时方案不一定适合未来扩展

api：https://rapidapi.com/irrors-apis/api/instagram-looter2
![image](https://github.com/user-attachments/assets/4c5b5844-691d-48f9-b693-d6a374c0847c)
![image](https://github.com/user-attachments/assets/d39bc3c8-87c6-4c16-986e-c334169b4e34)
![image](https://github.com/user-attachments/assets/dc7ed4e0-058a-4718-9d9c-1f3e0b54cdb3)
