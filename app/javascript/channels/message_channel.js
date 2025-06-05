import consumer from "channels/consumer" // ここが "channels/consumer" になっていることを確認

document.addEventListener("DOMContentLoaded", () => {
  const sendButton = document.getElementById("send_button");
  const usernameInput = document.getElementById("username_input");
  const messageInput = document.getElementById("message_input");
  const messagesDiv = document.getElementById("messages");

  // メッセージ表示部分の要素が存在することを確認
  if (!messagesDiv) {
    console.error("Messages div not found!");
    return;
  }

  const app = consumer.subscriptions.create("MessageChannel", {
    received(data) {
      // 受信したデータを新しいpタグとして作成し、messagesDivの先頭に追加
      const p = document.createElement("p");
      p.textContent = `${data.name}: ${data.body}`;
      messagesDiv.prepend(p);
    },

    sendMessage(name, msg) {
      // Action Cableチャネルのsend_messageメソッドを呼び出す
      return this.perform("send_message", { name: name, body: msg });
    }
  });

  // 送信ボタンがクリックされた時の処理
  sendButton?.addEventListener("click", (e) => {
    e.preventDefault(); // フォームのデフォルト送信をキャンセル

    const username = usernameInput.value;
    const message = messageInput.value;

    if (username && message) {
      app.sendMessage(username, message);
      messageInput.value = ""; // メッセージ入力フィールドをクリア
    } else {
      alert("Please enter both name and message.");
    }
  }, false);
});
