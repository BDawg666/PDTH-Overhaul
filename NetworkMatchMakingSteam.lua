local module = DorHUD:module('fgo')
local NetworkMatchMakingSTEAM = module:hook_class("NetworkMatchMakingSTEAM")

NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY = "FGO.0.2"