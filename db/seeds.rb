require 'httparty'
require 'action_view'

UserTask.destroy_all

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
  {
  "title": "Baking a Classic Cake",
  "description": "Select a timeless cake recipe such as chocolate, vanilla, or carrot cake, and embark on the journey of baking it from scratch. Explore the nuances of ingredient selection, mixing techniques, and baking times to achieve a moist and flavorful result reminiscent of traditional baking.",
  interests: [baking_intrests]
  },
  {
  "title": "Cookie Decorating Workshop",
  "description": "Immerse yourself in the world of cookie decorating through an interactive virtual workshop. Learn various techniques including flooding, piping, and royal icing consistency to create intricate designs on sugar cookies. Explore themes like holidays, seasons, or personal creativity as you enhance your cookie decorating skills.",
  interests: [baking_intrests]
  },
  {
  "title": "Bread Making Tutorial",
  "description": "Delve into the art of bread making with a comprehensive tutorial covering different types of bread, from rustic artisan loaves to soft sandwich bread. Explore the fundamentals of yeast fermentation, kneading, shaping, and proofing to master the craft of creating homemade bread that is crusty on the outside and tender on the inside.",
  interests: [baking_intrests]
  },
  {
  "title": "Cake Decorating Class",
  "description": "Enroll in an online cake decorating class led by expert instructors who will guide you through advanced techniques to transform plain cakes into works of art. Explore fondant sculpting, piping intricate designs, and creating elaborate cake toppers using gum paste. Unlock your creativity and elevate your cake decorating skills to the next level.",
  interests: [baking_intrests]
  },
  {
  "title": "Pie Baking Workshop",
  "description": "Join a virtual workshop focused on the art of pie baking, where you'll learn to master flaky pie crusts and delicious fillings. Explore classic flavors like apple, pumpkin, and pecan, as well as creative variations such as savory quiches or hand pies. Gain insights into techniques for achieving perfectly baked pies every time.",
  interests: [baking_intrests]
  },
  {
  "title": "Cupcake Decorating Challenge",
  "description": "Challenge yourself to a cupcake decorating challenge where you'll experiment with various piping tips, frosting textures, and decorative elements to create stunning cupcake designs. From elegant floral patterns to whimsical characters, unleash your imagination and showcase your cupcake decorating prowess.",
  interests: [baking_intrests]
  },
  {
  "title": "French Pastry Masterclass",
  "description": "Immerse yourself in the refined art of French pastry-making with a masterclass led by expert pastry chefs. Learn to create classic French pastries such as croissants, éclairs, and tarts, mastering techniques like laminating dough, piping choux pastry, and crafting delicate fruit fillings. Elevate your baking skills and impress with sophisticated French desserts.",
  interests: [baking_intrests]
  },
  {
  "title": "Chocolate Truffle Making",
  "description": "Indulge in the decadent world of chocolate truffles as you learn to craft velvety-smooth ganache fillings and coat them in rich, tempered chocolate. Discover flavor variations like dark chocolate, white chocolate, and infused ganaches, and explore creative coatings such as cocoa powder, chopped nuts, or edible gold dust.",
  interests: [baking_intrests]
  },
  {
  "title": "Artisan Bread Baking",
  "description": "Dive into the artisanal realm of bread baking, where you'll explore ancient techniques and modern innovations to create rustic loaves with complex flavors and textures. Experiment with sourdough starters, long fermentation times, and specialty grains to produce breads that are as visually stunning as they are delicious.",
  interests: [baking_intrests]
  },
  {
  "title": "Macaron Making Workshop",
  "description": "Embark on a macaron-making journey with a virtual workshop dedicated to mastering these delicate French confections. Learn the secrets to achieving the perfect meringue, mastering macaronage, and creating smooth, glossy shells in an array of vibrant colors. Explore fillings like ganache, buttercream, and fruit curds to customize your macarons to perfection.",
  interests: [baking_intrests]
  },
  {
  "title": "Learn to Play a Musical Instrument",
  "description": "Choose a musical instrument you've always wanted to learn and start taking lessons. Whether it's the guitar, piano, violin, or any other instrument, learning to play music can be a fulfilling and rewarding experience.",
  interests: [music_intrests]
  },
  {
  "title": "Songwriting Workshop",
  "description": "Participate in a songwriting workshop where you can learn the fundamentals of songwriting, including melody, lyrics, chord progressions, and song structure. Express your creativity and learn how to turn your ideas into original songs.",
  interests: [music_intrests]
  },
  {
  "title": "Music Production Course",
  "description": "Enroll in a music production course to learn the ins and outs of recording, mixing, and mastering music. Explore software such as Ableton Live, Pro Tools, or Logic Pro as you hone your skills in music production.",
  interests: [music_intrests]
  },
  {
  "title": "Singing Lessons",
  "description": "Take singing lessons to improve your vocal technique, range, and performance skills. Whether you're a beginner or an experienced singer, working with a vocal coach can help you develop your voice and express yourself through music.",
  interests: [music_intrests]
  },
  {
  "title": "Music Theory Class",
  "description": "Deepen your understanding of music theory by taking a music theory class. Learn about scales, chords, harmony, rhythm, and other essential concepts that form the foundation of music.",
  interests: [music_intrests]
  },
  {
  "title": "Jam Session with Friends",
  "description": "Organize a jam session with friends where you can play music together and improvise. Whether you're a band or a group of musicians, jamming with others is a great way to collaborate, learn from each other, and have fun making music.",
  interests: [music_intrests]
  },
  {
  "title": "Concert or Music Festival",
  "description": "Attend a concert or music festival to experience live music performances. Whether it's a small local gig or a large-scale music festival, live music events can be inspiring and enjoyable.",
  interests: [music_intrests]
  },
  {
  "title": "Music Appreciation Course",
  "description": "Take a music appreciation course to explore different genres, styles, and periods of music. Learn about the cultural and historical context of music and deepen your appreciation for the diverse world of music.",
  interests: [music_intrests]
  },
  {
  "title": "Collaborative Music Project",
  "description": "Collaborate with other musicians on a music project, such as recording a song, producing a music video, or composing a soundtrack. Working with others can spark creativity and lead to exciting musical collaborations.",
  interests: [music_intrests]
  },
  {
  "title": "Music Therapy Workshop",
  "description": "Attend a music therapy workshop to learn about the therapeutic benefits of music for mental health and well-being. Explore techniques for using music to reduce stress, enhance relaxation, and promote emotional expression and communication.",
  interests: [music_intrests]
  },
  {
  "title": "Language Exchange Meetup",
  "description": "Join a language exchange meetup where you can practice speaking with native speakers of the language you're learning. Language exchange events provide an opportunity to improve your speaking and listening skills in a casual and supportive environment.",
  interests: [language_intrests]
  },
  {
  "title": "Online Language Course",
  "description": "Enroll in an online language course to learn a new language at your own pace. Whether you're a beginner or looking to improve your proficiency, online language courses offer interactive lessons, exercises, and quizzes to help you master vocabulary, grammar, and pronunciation.",
  interests: [language_intrests]
  },
  {
  "title": "Language Immersion Program",
  "description": "Immerse yourself in a language immersion program where you can live and study in a country where the language is spoken. Language immersion programs provide intensive language instruction combined with cultural experiences, allowing you to accelerate your language learning and gain firsthand exposure to the language and culture.",
  interests: [language_intrests]
  },
  {
  "title": "Language Conversation Partner",
  "description": "Find a language conversation partner to practice speaking with regularly. Language conversation partners are native speakers of the language you're learning who are interestsed in learning your native language. By exchanging languages, you can both improve your speaking and listening skills through conversation and feedback.",
  interests: [language_intrests]
  },
  {
  "title": "Language Study Group",
  "description": "Join a language study group with other learners who are also studying the same language. Language study groups provide a supportive community where you can practice speaking, ask questions, and share resources and tips for language learning.",
  interests: [language_intrests]
  },
  {
  "title": "Language Learning App",
  "description": "Download a language learning app to practice language skills on the go. Language learning apps offer a variety of interactive exercises, games, and lessons to help you learn vocabulary, grammar, and pronunciation in a fun and engaging way.",
  interests: [language_intrests]
  },
  {
  "title": "Language Book Club",
  "description": "Join a language book club to read and discuss books in the language you're learning. Language book clubs provide an opportunity to practice reading, expand your vocabulary, and explore literature and culture in the target language.",
  interests: [language_intrests]
  },
  {
  "title": "Language Podcast or Audiobook",
  "description": "Listen to language podcasts or audiobooks to improve your listening comprehension and pronunciation. Language podcasts and audiobooks cover a wide range of topics and provide exposure to native speakers and authentic language use.",
  interests: [language_intrests]
  },
  {
  "title": "Language Cultural Event",
  "description": "Attend a language cultural event such as a film screening, concert, or festival in the language you're learning. Language cultural events provide an opportunity to experience the language and culture in a real-world context and connect with others who share your language interestss.",
  interests: [language_intrests]
  },
  {
  "title": "Language Certification Exam",
  "description": "Prepare for a language certification exam to assess your proficiency level and earn a recognized qualification. Language certification exams are available for many languages and provide a goal to work towards as you progress in your language learning journey.",
  interests: [language_intrests]
  },
  {
    "title": "Try a New Hobby",
    "description": "Explore a new hobby or activity that interests you. It could be anything from painting to gardening to woodworking. Discovering new hobbies can bring joy and fulfillment to your life.",
    interests: [misc_intrests, life_intrests]
  },
  {
    "title": "Volunteer for a Cause",
    "description": "Give back to your community by volunteering for a cause you're passionate about. Whether it's helping the homeless, tutoring children, or cleaning up the environment, volunteering can make a positive impact on the world.",
    interests: [misc_intrests, life_intrests]
  },
  {
    "title": "Random Act of Kindness",
    "description": "Brighten someone's day by performing a random act of kindness. It could be as simple as offering a compliment or helping someone in need.",
    interests: [misc_intrests, life_intrests]
  },
  {
    "title": "Brainstorm and Write Down 10 New Ideas",
    "description": "Exercise your creativity by brainstorming and jotting down 10 new ideas. They could be related to work, hobbies, or personal projects.",
    interests: [misc_intrests]
  },
  {
    "title": "Attend a Virtual Workshop or Webinar",
    "description": "Enhance your skills or knowledge by attending a virtual workshop or webinar on a topic of interest. Many platforms offer free or affordable options.",
    interests: [misc_intrests]
  },
  {
    "title": "Learn a New Language",
    "description": "Challenge yourself by learning a new language. Whether it's Spanish, French, or Mandarin, acquiring a new language opens up new opportunities and broadens your perspective.",
    interests: [misc_intrests, language_intrests]
  },
  {
    "title": "Start a Journal",
    "description": "Begin a journaling practice to reflect on your thoughts, feelings, and experiences. Journaling can help you gain clarity, reduce stress, and track your personal growth over time.",
    interests: [misc_intrests]
  },
  {
    "title": "Practice Meditation",
    "description": "Take time to cultivate mindfulness and inner peace through meditation. Whether it's a guided meditation session or silent meditation, incorporating mindfulness into your daily routine can promote relaxation and mental well-being.",
    interests: [misc_intrests]
  },
  {
    "title": "Explore Local Art and Culture",
    "description": "Immerse yourself in the art and culture of your local community. Visit museums, galleries, theaters, or attend cultural events to broaden your horizons and appreciate the richness of your surroundings.",
    interests: [misc_intrests]
  },
  {
    "title": "Create a Bucket List",
    "description": "Compile a list of experiences, goals, and aspirations you want to achieve in your lifetime. Whether it's traveling to exotic destinations, learning new skills, or accomplishing personal milestones, a bucket list can inspire you to live life to the fullest.",
    interests: [misc_intrests]
  },
  {
    "title": "Explore a New Cuisine",
    "description": "Step out of your culinary comfort zone and explore a new cuisine. Whether it's Thai, Indian, or Ethiopian, trying new dishes can tantalize your taste buds and introduce you to exciting flavors and spices.",
    interests: [misc_intrests, cooking_intrests]
  },
  {
    "title": "Practice Gratitude",
    "description": "Cultivate gratitude by acknowledging and appreciating the blessings in your life. Take time each day to reflect on the things you're grateful for, whether it's the support of loved ones, a beautiful sunset, or a delicious meal.",
    interests: [misc_intrests]
  },
  {
    "title": "Create a Personal Mission Statement",
    "description": "Define your values, goals, and purpose in life by crafting a personal mission statement. Clarifying your core beliefs and aspirations can provide direction and motivation as you navigate your life's journey.",
    interests: [misc_intrests]
  },
  {
    "title": "Start a Book Club",
    "description": "Gather friends or colleagues to form a book club where you can discuss and explore literature together. Reading and sharing insights on books can foster meaningful connections and intellectual stimulation.",
    interests: [misc_intrests, reading_intrests]
  },
  {
    "title": "Practice Random Acts of Kindness",
    "description": "Spread joy and kindness by performing random acts of kindness for others. Whether it's paying for someone's coffee, giving a compliment, or volunteering your time, small gestures can make a big difference in someone's day.",
    interests: [misc_intrests]
  },
  {
    "title": "Start a Gratitude Journal",
    "description": "Cultivate a positive mindset by keeping a gratitude journal. Each day, write down three things you're grateful for, no matter how big or small. Practicing gratitude can increase happiness and well-being.",
    interests: [misc_intrests]
  },
  {
    "title": "Create a Vision Board",
    "description": "Visualize your dreams and goals by creating a vision board. Gather images, quotes, and symbols that represent your aspirations and arrange them on a board. Displaying your vision board in a prominent place can serve as a daily reminder of what you're working towards.",
    interests: [misc_intrests]
  },
  {
    "title": "Try Mindfulness Meditation",
    "description": "Practice mindfulness meditation to cultivate present moment awareness and reduce stress. Focus on your breath, sensations in your body, or the sounds around you as you anchor yourself in the present moment.",
    interests: [misc_intrests, life_intrests]
  },
  {
    "title": "Explore a New Hobby or Skill",
    "description": "Discover a new hobby or skill that interests you, whether it's painting, photography, cooking, or playing a musical instrument. Engaging in creative or hands-on activities can bring joy and fulfillment to your life.",
    interests: [misc_intrests]
  },
  {
    "title": "Connect with Nature",
    "description": "Spend time outdoors connecting with nature. Whether it's going for a hike, picnicking in the park, or stargazing at night, immersing yourself in the natural world can rejuvenate your body, mind, and spirit.",
    interests: [misc_intrests]
  }

]

tasks.each do |task|
  new_task = Task.create(title: task[:title], description: task[:description])
  task[:interests].each { |interest| new_task.interests << interest } if task[:interests]
end

p "Seed data for tasks has been added."
