# Get your Trello API Key here: https://trello.com/1/appKey/generate
apiKey   = ''

# Replace 'INSERTYOURAPIKEY' below with your apiKey above, and navigate to the url.
# Goto: https://trello.com/1/authorize?key=INSERTYOURAPIKEY&name=Ubersicht+Trello+Widget&expiration=never&response_type=token
# Hit Authorize, and paste your token here.
token = ''

# Get your Board Id by navigating to the Board you want in Trello, and copying the bit after /b/ and before the last /
# For example a board named https://trello.com/b/5d9adhe0/my-stuff your Board Id is: 5d9adhe0
boardId = ''

# Get your User Id by navigating to the url https://api.trello.com/1/members/INSERTYOURUSERNAMEHERE
userId = ''

# Finally enter the name of the List you want to have displayed
listName = ''


# You're Done!

command: "curl -s 'https://api.trello.com/1/boards/#{boardId}/lists?fields=name&cards=open&card_fields=name,idMembers&key=#{apiKey}&token=#{token}'"
refreshFrequency: 10000

update: (output, domEl) ->
  data  = JSON.parse(output)
  for list of data
    listData = data[list] if data[list].name is listName
  $domEl = $(domEl)
  
  $domEl.html("<h1 class='listName'>#{listData.name}</h1>")
  $domEl.append("<ul>")

  for item in listData.cards
    if !userId || item.idMembers.includes(userId)
      $domEl.append @renderItem(item)
  
  $domEl.append("</ul>")

renderItem: (data) ->
  """
    <li>#{data.name}</li>
  """

style: """
  top: 30px
  left: 30px
  color: #fff
  font-family: Helvetica Neue
  /* text-align: center */
  width: 340px

  li
    /* background-color: black */
    opacity .7
    border-radius 5px
    margin-bottom 12px
    
  .listName
    font-size: 1.5em
    opacity .5

  ul
    margin 0
    padding 0
"""
