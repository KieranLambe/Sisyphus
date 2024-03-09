# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'httparty'


def fetch_wger_data(endpoint, access_token, language, limit)
  url = "https://wger.de/api/v2/#{endpoint}/"
  params = { 'language' => language, 'limit' => limit}
  response = HTTParty.get(url, headers: { 'Authorization' => "Bearer #{access_token}" }, query: params)
  # Check if the request was successful
  return [] unless response.success?

  # Parse the API response and return the results
  JSON.parse(response.body)['results']
end

# Authenticate and get the access token
auth_response = HTTParty.post(
  'https://wger.de/api/v2/token',
  body: { username: 'hjosh100', password: '@Lewagon12345' }
)

access_token = auth_response['access']

# Fetch exercises from the wger API
exercises = fetch_wger_data('exercise', access_token, 2, 50)

# Create tasks based on fetched data
tasks_data = exercises.map do |exercise|
  {
    title: exercise['name'],
    description: "#{exercise['description']}",
  }
end

# Create tasks from API data
tasks_data.each do |task_params|
  Task.create(task_params)
end

puts 'Seed data for tasks has been added from the wger API.'



def fetch_yoga_data
  url = "https://yoga-api-nzy4.onrender.com/v1/poses"
  response = HTTParty.get(url)

  # Check if the request was successful
  unless response.success?
    puts "Error fetching yoga data. HTTP Status Code: #{response.code}"
    return []
  end

  # Parse the API response and return a filtered list with only english_name and pose_description
  begin
    parsed_data = JSON.parse(response.body)
    filtered_data = parsed_data.map { |pose| { "title" => pose["english_name"], "description" => pose["pose_description"] } }
    return filtered_data
  rescue JSON::ParserError => e
    puts "Error parsing JSON response: #{e.message}"
    return []
  end
end

yogaposes = fetch_yoga_data

yogaposes.each do |task_params|
  Task.create(task_params)
end

puts 'seed data for yoga poses has been added from the yoga API.'


def fetch_recipe_data
  url = "https://api.spoonacular.com/recipes/random?number=50"
  response = HTTParty.get(url, query: { apiKey: "34996ede53764fab8ea8b2514543b0a0" })

  return [] unless response.success?

  parsed_data = JSON.parse(response.body)

  actual_data = parsed_data["recipes"].map do |recipe|
    { "title" => recipe["title"], "description" => recipe["summary"] }
  end

  actual_data
end

recipes = fetch_recipe_data

recipes.each do |task_params|
  Task.create(task_params)
end
puts "Seed data for recipes has been added from the spoonacular API."


tasks = [
  { title: "Conduct a Random Act of Kindness", description: "Brighten someone's day by performing a random act of kindness. It could be as simple as offering a compliment or helping someone in need." },
  { title: "Brainstorm and Write Down 10 New Ideas", description: "Exercise your creativity by brainstorming and jotting down 10 new ideas. They could be related to work, hobbies, or personal projects." },
  { title: "Learn a New Instrumental Skill", description: "If you have a musical instrument lying around, dedicate some time to learning a new skill or playing a new song." },
  { title: "Do a Nature Sketch or Painting", description: "Head outdoors, observe nature, and create a sketch or painting inspired by what you see." },
  { title: "Attend a Virtual Workshop or Webinar", description: "Enhance your skills or knowledge by attending a virtual workshop or webinar on a topic of interest. Many platforms offer free or affordable options." },
  { title: "Learn a New Dance Move", description: "Spice up your day by learning a new dance move. Whether it's a simple step or a full routine, have fun and get moving!" },
  { title: "Write a Letter to Your Future Self", description: "Reflect on your goals, aspirations, and current thoughts by writing a letter to your future self. Seal it and open it at a later date for a self-discovery moment." },
  { title: "Create a Vision Board", description: "Unleash your creativity by making a vision board. Cut out images and quotes that inspire you and represent your goals." },
  { title: "Try a New Type of Cuisine", description: "Explore the culinary world by trying a new type of cuisine. Cook a dish or order from a restaurant you haven't experienced before." },
  { title: "Practice Mindful Walking", description: "Take a break and practice mindful walking. Pay attention to each step, your surroundings, and the sensations you experience." },
  { title: "Explore a New Podcast", description: "Broaden your knowledge or entertain yourself by exploring a new podcast on a topic that interests you." },
  { title: "Do a Digital Detox for an Hour", description: "Unplug from digital devices for an hour. Use the time to read, go for a walk, or engage in an offline activity." },
  { title: "Write a Gratitude Journal Entry", description: "Cultivate a positive mindset by writing a gratitude journal entry. Acknowledge and appreciate the good things in your life." },
  { title: "Learn a Magic Trick", description: "Amaze yourself and others by learning a simple magic trick. It's a great way to add a touch of wonder to your day." },
  { title: "Plan a DIY Home Improvement Project", description: "Channel your creativity into a home improvement project. Whether it's rearranging furniture or adding new decorations, make your space feel fresh." },
  { title: "Conduct a Random Act of Kindness", description: "Brighten someone's day by performing a random act of kindness. It could be as simple as offering a compliment or helping someone in need." },
  { title: "Brainstorm and Write Down 10 New Ideas", description: "Exercise your creativity by brainstorming and jotting down 10 new ideas. They could be related to work, hobbies, or personal projects." },
  { title: "Learn a New Instrumental Skill", description: "If you have a musical instrument lying around, dedicate some time to learning a new skill or playing a new song." },
  { title: "Do a Nature Sketch or Painting", description: "Head outdoors, observe nature, and create a sketch or painting inspired by what you see." },
  { title: "Attend a Virtual Workshop or Webinar", description: "Enhance your skills or knowledge by attending a virtual workshop or webinar on a topic of interest. Many platforms offer free or affordable options." },
  { title: "Try a New Dance Move", description: "Spice up your day by learning a new dance move. Whether it's a simple step or a full routine, have fun and get moving!" },
  { title: "Write a Letter to Your Future Self", description: "Reflect on your goals, aspirations, and current thoughts by writing a letter to your future self. Seal it and open it at a later date for a self-discovery moment." },
  { title: "Create a Vision Board", description: "Unleash your creativity by making a vision board. Cut out images and quotes that inspire you and represent your goals." },
  { title: "Try a New Type of Cuisine", description: "Explore the culinary world by trying a new type of cuisine. Cook a dish or order from a restaurant you haven't experienced before." },
  { title: "Practice Mindful Walking", description: "Take a break and practice mindful walking. Pay attention to each step, your surroundings, and the sensations you experience." },
  { title: "Explore a New Podcast", description: "Broaden your knowledge or entertain yourself by exploring a new podcast on a topic that interests you." },
  { title: "Do a Digital Detox for an Hour", description: "Unplug from digital devices for an hour. Use the time to read, go for a walk, or engage in an offline activity." },
  { title: "Write a Gratitude Journal Entry", description: "Cultivate a positive mindset by writing a gratitude journal entry. Acknowledge and appreciate the good things in your life." },
  { title: "Learn a Magic Trick", description: "Amaze yourself and others by learning a simple magic trick. It's a great way to add a touch of wonder to your day." },
  { title: "Plan a DIY Home Improvement Project", description: "Channel your creativity into a home improvement project. Whether it's rearranging furniture or adding new decorations, make your space feel fresh." },
  { title: "Conduct a Random Act of Kindness", description: "Brighten someone's day by performing a random act of kindness. It could be as simple as offering a compliment or helping someone in need." },
  { title: "Brainstorm and Write Down 10 New Ideas", description: "Exercise your creativity by brainstorming and jotting down 10 new ideas. They could be related to work, hobbies, or personal projects." },
  { title: "Learn a New Instrumental Skill", description: "If you have a musical instrument lying around, dedicate some time to learning a new skill or playing a new song." },
  { title: "Do a Nature Sketch or Painting", description: "Head outdoors, observe nature, and create a sketch or painting inspired by what you see." },
  { title: "Attend a Virtual Workshop or Webinar", description: "Enhance your skills or knowledge by attending a virtual workshop or webinar on a topic of interest. Many platforms offer free or affordable options." }
]

tasks.each do |task|
  Task.create(title: task[:title], description: task[:description])
end


intrests = [
{ title: "Music"},
{ title: "Sports"},
{ title: "Baking"},
{ title: "Cooking"},
{ title: "Language"},
{ title: "Reading"},
{ title: "Misc"},
]

intrests.each do |intrest|
  Interest.create(title: intrest[:title])
end
