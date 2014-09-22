class Unauthorization < ActionController::InvalidAuthenticityToken ; end # 401
class Forbidden       < ActionController::ActionControllerError    ; end # 403
