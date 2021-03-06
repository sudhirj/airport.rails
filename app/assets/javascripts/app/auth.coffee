
exports.set = set = (options) ->
    console.log 'Setting new token:', options.token
    console.log 'Setting new user:', options.login
    localStorage.setItem 'token', options.token
    localStorage.setItem 'login', options.login

exports.getLogin = getLogin = -> localStorage.getItem('login')
exports.getToken = getToken = -> localStorage.getItem('token')
exports.isLoggedIn = isLoggedIn = -> !!(getToken() and getLogin())
exports.isCurrentUser = isCurrentUser = (login) -> isLoggedIn() and (login is getLogin())

exports.logout = logout = -> 
    localStorage.removeItem('token')
    localStorage.removeItem('login')
    window.location.reload()

