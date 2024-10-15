# GreatiOSApp
Task for Great iOS developer

Few simple steps
Read all requirements
[Get design requirements (sign up to be able to view editable assets)](https://www.figma.com/design/5DVu3HbepBlWVjXDZVo360/Great-task-for-Great-iOS-Developer?node-id=0-1&node-type=canvas&t=kTSNK7ylgTeMZjKQ-0)
Do your best
When you’re done, prepare an archive and send it to us
Few simple requirements
Create a 2 screen app. First is the login screen, second is the server list. After login, the user should access a server list screen. If you implemented credential storage, on app open, the user should skip the login screen and start from the server list screen.
Design should be recreated as closely as possible.
Write high quality, beautiful code.
To generate authorization token, send POST request to https://playground.nordsec.com/v1/tokens.
Request body: 
{"username": "tesonet", "password": "partyanimal"}
Get servers list from https://playground.nordsec.com/v1/servers. Add header to request: Authorization: Bearer <token> *
Create persistent layer to store servers
Handle 401 response
Write unit/integration tests
Few tips
Follow modern apps development best practices
If you find a nice library/framework that can make your life easier, use it.
Have fun!
Bonus points
Implement credential storage in keychain
