require 'rails_helper'

RSpec.feature 'Post index page', type: :feature do
  before do
    @first_user = User.create(name: 'Akeem Fauszi', bio: 'He is a developer',
                              photo: 'https://avatars.githubusercontent.com/u/114492335?v=4',
                              posts_counter: 0)

    # ... (other post and comment creations)

    visit user_posts_path(@first_user)
  end

  scenario 'should display user profile image' do
    expect(page).to have_css("img[src*='https://avatars.githubusercontent.com/u/114492335?v=4']")
  end

  scenario 'should display user name, and its number of post' do
    expect(page).to have_content('Akeem Fauszi')
    expect(page).to have_content('Number of posts: 4')
  end

  scenario 'should show all the posts title' do
    expect(page).to have_content('The first post')
    expect(page).to have_content('The second post')
    expect(page).to have_content('The third post')
    expect(page).to have_content('The fourth post')
  end

  scenario 'should show some of the post text' do
    expect(page).to have_content('Content for the first post')
    expect(page).to have_content('Content for the second post')
    expect(page).to have_content('Content for the third post')
    expect(page).to have_content('Content for the fourth post')
  end

  scenario 'should display five most recent comments for a post' do
    expect(page).to have_content('This the sixth comment for first post')
    # ... (other comments)
  end

  scenario 'should show number of comments for a post' do
    expect(page).to have_content('Comments: 6')
    # ... (other comments count assertions)
  end

  scenario 'should show the number of likes for a post' do
    expect(page).to have_content('Likes: 4')
    # ... (other likes count assertions)
  end

  scenario 'should redirects to the post detail page when a post is clicked' do
    click_link @second_post.title
    expect(page).to have_current_path(user_post_path(@first_user, @second_post))
  end

  scenario 'should show pagination when there are more posts than fit on the view' do
    # Create more posts to exceed the number that fits on the view
    additional_posts = []
    10.times do |i|
      additional_posts << Post.create(author: @first_user, title: "Extra Post #{i}",
                                      text: "Content for Extra Post #{i}",
                                      comments_counter: 0, likes_counter: 0)
    end

    visit user_posts_path(@first_user)

    expect(page).to have_selector('.pagination')
    # You can also add more specific expectations about the pagination UI elements
  end
end
