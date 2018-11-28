## 1.0.0

- Initial version, created by Stagehand

## Server
- 服务端完成情况：端口：8002, 路由：/users（全部随机数的数组）, /users/[:id] 单个随机数，
生成的随机数现在是默认10个，显示的结果是加上lower_bound = 10164507101后的学号的格式，随机数的调用在构造函数中进行。