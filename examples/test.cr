require "../src/skeleton"
require "json"

def get_drinks
    RandomDatabase.new.call_db_and_get_data;
end

backend = Skeleton::Server.new
    .add(Skeleton::ErrorHandler.new)
    .add(Skeleton::LogHandler.new)
    .add(Skeleton::CORSHandler.new)
    .add(Skeleton::RouteHandler.new
        .get "/drinks_database" {
            Skeleton::Application::JSON.new get_drinks.to_json;
        }
    )
    .create()
    .bind_tcp("127.0.0.1", 3001);

frontend = Skeleton::Server.new
    .add(Skeleton::RouteHandler.new
        .get "/" {
            Skeleton::Text::HTML.new "./src/public/index.html";
        }
    )
    .add(Skeleton::StaticFileHandler.new "./src/public/")
    .create()
    .bind_tcp("127.0.0.1", 3000);

spawn { backend.listen; };
frontend.listen;

class RandomDatabase
    def call_db_and_get_data
        {
            "drinks":
            [
                {
                    "id": 1,
                    "icon": "🍓",
                    "name": "Strawberry Limeade",
                    "url": "https://www.youtube.com/watch?v=SqSZ8po1tmU"
                },
                {
                    "id": 2,
                    "icon": "⛱ ",
                    "name": "Melon Sorbet Float",
                    "url": "https://www.youtube.com/watch?v=hcqMtASkn8U"
                },
                {
                    "id": 3,
                    "icon": "🍨",
                    "name": "Raspberry Vanilla Soda",
                    "url": "https://www.youtube.com/watch?v=DkARNOFDnwA"
                },
                {
                    "id": 4,
                    "icon": "🌴",
                    "name": "Cantaloupe Mint Agua Fresca",
                    "url": "https://www.youtube.com/watch?v=Zxz-DYSKcIk"
                }
            ]
        };
    end
end

