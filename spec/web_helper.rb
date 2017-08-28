# def sign_up
#   visit '/signup'
#   expect(page.status_code).to eq(200)
#   fill_in :email,    with: 'alice@example.com'
#   fill_in :password, with: 'oranges!'
#   fill_in :password2, with: 'oranges!'
#   click_button 'Sign up'
# end

# def false_sign_up
#   visit '/signup'
#   expect(page.status_code).to eq(200)
#   fill_in :email,    with: 'alice@example.com'
#   fill_in :password, with: 'oranges!'
#   fill_in :password2, with: 'oranges!'
#   click_button 'Sign up'
# end

def sign_up(email: 'eli@example.com',password: '12345678',password2: '12345678')
    visit '/signup'
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password2, with: password2
    click_button 'Sign up'
  end
