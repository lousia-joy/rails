import consumer from "channels/consumer"

function subscribeToTopic(topicName) {
  consumer.subscriptions.create(
    { channel: "TopicChannel", topic: topicName },
    {
      connected() {
        console.log(`————————————已连接到话题 ${topicName} 的 WebSocket`);
      },
      received(data) {
        console.log("——————————收到广播内容：", data);
        if (data.html) {
          const container = document.querySelector(".post-container")?.parentNode;
          if (container) {
            const temp = document.createElement("div");
            temp.innerHTML = data.html;
            container.prepend(temp.firstElementChild); // 插入最前面
          }
        }
      }
    }
  );
}

window.subscribeToTopic = subscribeToTopic;
