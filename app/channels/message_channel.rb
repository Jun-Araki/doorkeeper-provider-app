class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "general" # "general" ストリームに接続
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # クライアントからの `perform("send_message", data)` に対応する
  def send_message(data)
    name = data['name']
    body = data['body']

    # データベースに保存
    message = Message.create(topic: "general", name: name, body: body)

    # 接続している全てのクライアントにメッセージをブロードキャスト
    # received(data) で受け取る形式に合わせる
    ActionCable.server.broadcast("general", { name: message.name, body: message.body })
  end
end
