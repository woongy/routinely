module Actors
  class Socket < Actor
    store_accessor :config, :tx_subflow

    def to_nodes(payload, x = 100, y = 100)
      actor_id = SecureRandom.uuid
      socket_id = SecureRandom.uuid

      return actor_id, [
        {
          id: actor_id,
          x: x += 200,
          y: y,
          type: "ninja-send",
          d: "rf",
          da: payload["da"], # 0xdadada for on, 0xdadad2 for off
          wires: [[socket_id]]
        },
        {
          id: socket_id,
          x: x += 200,
          y: y,
          type: "subflow:#{tx_subflow}",
          wires: []
        }
      ]
    end
  end
end
