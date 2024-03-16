require 'httparty'
require 'action_view'

Task.all.each do |task|
  task.interests.clear
end

Task.destroy_all
puts 'Tasks have been destroyed'
intrests = [
{ title: "Music"},
{ title: "Sports"},
{ title: "Baking"},
{ title: "Cooking"},
{ title: "Language"},
{ title: "Reading"},
{ title: "Lifestyle"},
{ title: "Misc"},
]

include ActionView::Helpers::SanitizeHelper

intrests.each do |intrest|
  Interest.create(title: intrest[:title])
end
music_intrests = Interest.where(title: "Music")
sport_intrests = Interest.where(title: "Sports")
baking_intrests = Interest.where(title: "Baking")
cooking_intrests = Interest.where(title: "Cooking")
language_intrests = Interest.where(title: "Language")
reading_intrests = Interest.where(title: "Reading")
life_intrests = Interest.where(title: "Lifestyle")
misc_intrests = Interest.where(title: "Misc")

def fetch_wger_data(endpoint, access_token, language, limit)
  url = "https://wger.de/api/v2/#{endpoint}/"
  params = { 'language' => language, 'limit' => limit}
  response = HTTParty.get(url, headers: { 'Authorization' => "Bearer #{access_token}"}, query: params)
  return [] unless response.success?

  JSON.parse(response.body)['results']
end

auth_response = HTTParty.post(
  'https://wger.de/api/v2/token',
  body: { username: 'hjosh100', password: '@Lewagon12345' }
)

access_token = auth_response['access']

exercises = fetch_wger_data('exercise', access_token, 'en', 100)

tasks_data = exercises.map do |exercise|
  {
    title: exercise['name'],
    description: strip_tags(exercise['description']).presence || 'No description available'
  }
end



tasks_data.each do |task_params|
  new_task = Task.create(task_params)

  interest_title = "Sports"
  interest = Interest.find_or_create_by!(title: interest_title)
  if(new_task.id.present?)
    interest_task = InterestTask.create!(interest: interest, task: new_task)
  end
end

puts 'Seed data for tasks has been added from the wger API.'



def fetch_yoga_data
  url = "https://yoga-api-nzy4.onrender.com/v1/poses"
  response = HTTParty.get(url)
  return [] unless response.success?

  parsed_data = JSON.parse(response.body)
  filtered_data = parsed_data.map { |pose| { "title" => pose["english_name"], "description" => pose["pose_description"] } }

end

yogaposes = fetch_yoga_data

yogaposes.each do |task_params|
  new_task = Task.create(task_params)
  sports_interest = Interest.find_or_create_by!(title: "Sports")
  lifestyle_interest = Interest.find_or_create_by!(title: "Lifestyle")
  new_task.interests << sports_interest
  new_task.interests << lifestyle_interest
end

puts 'seed data for yoga poses has been added from the yoga API.'


def fetch_recipe_data
  url = "https://api.spoonacular.com/recipes/random?number=50"
  response = HTTParty.get(url, query: { apiKey: "34996ede53764fab8ea8b2514543b0a0" })

  return [] unless response.success?

  parsed_data = JSON.parse(response.body)

  actual_data = parsed_data["recipes"].map do |recipe|
    { "title" => recipe["title"], "description" => strip_tags(recipe["summary"]) }
  end

  actual_data
end

recipes = fetch_recipe_data

recipes.each do |task_params|
  new_task = Task.create(task_params)

  cooking_intrests = Interest.find_or_create_by!(title: "Cooking")

  cooking_intrests.tasks << new_task
end
puts "Seed data for recipes has been added from the spoonacular API."


def fetch_book_data
  url = "https://books-api7.p.rapidapi.com/books/get/random/"
  headers = { "X-RapidAPI-Key" => "4554b15d14msh39ff42284fa55b6p120f45jsn70608139d682",
  "X-RapidAPI-Host" => "books-api7.p.rapidapi.com" }

    response = HTTParty.get(url, headers: headers)

    return [] unless response.success?

    parsed_data = JSON.parse(response.body)

    title = parsed_data["title"]
    description = parsed_data["plot"]

    [{ "title" => title, "description" => description }]

end

books = fetch_book_data

books.each do |task_params|
  new_task = Task.create(task_params)

  reading_interests = Interest.find_or_create_by!(title: "Reading")

  new_task.interests << reading_interests
end

p "Seed data for books has been added from the books API."

def fetch_google_book_data(query, max_results = 40)
  url = 'https://www.googleapis.com/books/v1/volumes'
  api_key = 'AIzaSyAAtoNMtinl8XQXQTpHJ7T8JERdVhJ_4ws'
  query_params = { q: query, maxResults: max_results, key: api_key }
  response = HTTParty.get(url, query: query_params)

  if response.success?
    parsed_data = JSON.parse(response.body)
    if parsed_data['totalItems'] > 0
      parsed_data['items'].map do |item|
        volume_info = item['volumeInfo']
        { 'title' => volume_info['title'], 'description' => volume_info['description'] }
      end
    else
      puts 'No books found.'
      []
    end
  else
    puts "Error: #{response.code}, #{response.message}"
    []
  end
end

google_books = fetch_google_book_data('best sellers')

google_books.each do |task_params|
  new_task = Task.create(task_params)

  reading_interests = Interest.find_or_create_by!(title: "Reading")

  new_task.interests << reading_interests
end

p "Seed data for books has been added from the google books API."

tasks = [
  { title: "Conduct a Random Act of Kindness", description: "Brighten someone's day by performing a random act of kindness. It could be as simple as offering a compliment or helping someone in need.", interests: [life_intrests] },
  { title: "Brainstorm and Write Down 10 New Ideas", description: "Exercise your creativity by brainstorming and jotting down 10 new ideas. They could be related to work, hobbies, or personal projects.", interests: [life_intrests] },
  { title: "Learn a New Instrumental Skill", description: "If you have a musical instrument lying around, dedicate some time to learning a new skill or playing a new song.", interests: [music_intrests] },
  { title: "Do a Nature Sketch or Painting", description: "Head outdoors, observe nature, and create a sketch or painting inspired by what you see.", interests: [misc_intrests] },
  { title: "Attend a Virtual Workshop or Webinar", description: "Enhance your skills or knowledge by attending a virtual workshop or webinar on a topic of interest. Many platforms offer free or affordable options.", interests: [life_intrests] },
  { title: "Learn a New Dance Move", description: "Spice up your day by learning a new dance move. Whether it's a simple step or a full routine, have fun and get moving!", interests: [life_intrests, sport_intrests] },
  { title: "Write a Letter to Your Future Self", description: "Reflect on your goals, aspirations, and current thoughts by writing a letter to your future self. Seal it and open it at a later date for a self-discovery moment.", interests: [life_intrests] },
  { title: "Create a Vision Board", description: "Unleash your creativity by making a vision board. Cut out images and quotes that inspire you and represent your goals.", interests: [life_intrests] },
  { title: "Try a New Type of Cuisine", description: "Explore the culinary world by trying a new type of cuisine. Cook a dish or order from a restaurant you haven't experienced before.", interests: [cooking_intrests, life_intrests] },
  { title: "Practice Mindful Walking", description: "Take a break and practice mindful walking. Pay attention to each step, your surroundings, and the sensations you experience.", interests: [life_intrests, sport_intrests] },
  { title: "Explore a New Podcast", description: "Broaden your knowledge or entertain yourself by exploring a new podcast on a topic that interests you.", interests: [life_intrests] },
  { title: "Do a Digital Detox for an Hour", description: "Unplug from digital devices for an hour. Use the time to read, go for a walk, or engage in an offline activity.", interests: [life_intrests] },
  { title: "Write a Gratitude Journal Entry", description: "Cultivate a positive mindset by writing a gratitude journal entry. Acknowledge and appreciate the good things in your life.", interests: [life_intrests] },
  { title: "Learn a Magic Trick", description: "Amaze yourself and others by learning a simple magic trick. It's a great way to add a touch of wonder to your day.", interests: [life_intrests] },
  { title: "Plan a DIY Home Improvement Project", description: "Channel your creativity into a home improvement project. Whether it's rearranging furniture or adding new decorations, make your space feel fresh.", interests: [life_intrests] },
  { title: "Conduct a Random Act of Kindness", description: "Brighten someone's day by performing a random act of kindness. It could be as simple as offering a compliment or helping someone in need.", interests: [life_intrests] },
  { title: "Brainstorm and Write Down 10 New Ideas", description: "Exercise your creativity by brainstorming and jotting down 10 new ideas. They could be related to work, hobbies, or personal projects.", interests: [life_intrests] },
  { title: "Learn a New Instrumental Skill", description: "If you have a musical instrument lying around, dedicate some time to learning a new skill or playing a new song.", interests: [music_intrests] },
  { title: "Do a Nature Sketch or Painting", description: "Head outdoors, observe nature, and create a sketch or painting inspired by what you see.", interests: [misc_intrests] },
  { title: "Attend a Virtual Workshop or Webinar", description: "Enhance your skills or knowledge by attending a virtual workshop or webinar on a topic of interest. Many platforms offer free or affordable options.", interests: [life_intrests] },
]

tasks.each do |task|
  new_task = Task.create(title: task[:title], description: task[:description])
  task[:interests].each { |interest| new_task.interests << interest } if task[:interests]
end

p "Seed data for tasks has been added."
