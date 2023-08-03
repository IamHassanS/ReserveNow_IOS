import Foundation
import Alamofire

enum APIEnums : String{
    
    
    case force_update = "check_version"
    case language_content = "content"
    case login = "login"
    case logout = "logout"
    case socialSignup = "signup"
    case getHomeData = "home"
    case getExploreData = "explore"
    case exploreExperiences = "explore_experiences"
    case exploreExperienceCategories = "host_experience_categories"
    case view_profile = "view_profile"
    case user_profile_details = "user_profile_details"
    case none
    case trip_type = "trips_type"
    case tripDetails = "trips_details"
    case instantTripDetails = "instant_trip_details"
    case experience = "experience"
    case getWishList = "get_wish_list"
    case getStayDetail = "rooms"
    case getReviewDetail = "review_detail"
    case getExpReviewData = "experience_review_detail"
    case toRemoveFromWishlist = "delete_wishlist"
    case getWishLists = "get_whishlist"
    case addWishList = "add_wishlists"
    case getWishLIstDetails = "get_particular_wishlist"
    case editWishList = "edit_wishlist"
    case getFilterAmenities = "amenities_list"
    case messageHost = "contact_request"
    //case getRoomOptions = "room_property_type"
    case edit_profile = "edit_profile"
    case forgotPassword = "forgotpassword"
    case currency_list = "currency_list"
    case currency_change = "currency_change"
    case change_room_currency = "update_room_currency"
    case language = "language"
    case experiences_contact_host = "experiences/contact_host"
    case choose_date  = "choose_date"
    case calendar_availability_status = "calendar_availability_status"
    case account_delete = "delete_account"
    case payout_makedefault = "payout_makedefault"
    case payout_delete = "payout_delete"
    case payout_changes = "payout_changes"
    case payout_details = "payout_details"
    case country_list = "country_list"
    case add_payout_perference = "add_payout_perference"
    case stripe_supported_country_list = "stripe_supported_country_list"
    case inbox_reservation = "inbox_reservation"
    case roomPropertyType = "room_property_type"
    case prePayment = "pre_payment"
    case reservation_list = "reservation_list"
    case experience_pre_payment = "experience_pre_payment"
    case updateBedRooms = "update_bed_detail"
    case addNewRoom = "new_add_room"
    case hostCalendar = "rooms_list_calendar"
    case updateCalendar = "new_update_calendar"
    case listing = "listing"
    case conversation_list = "conversation_list"
    case update_amenities = "update_amenities"
    case updateDeviceId = "update_device_id"
    case updateRoomPrice = "add_rooms_price"
    case removeStayImage = "remove_uploaded_image"
    case addStayImage = "room_image_upload"
    // case updateDeviceId = "update_device_id"
    case update_description
    case update_title_description
    case update_house_rules
    case get_bank_details = "flutterwave/get_bank_details"
    case flutterwave_payout_method = "flutterwave/payout_method"

   // case updateDeviceId = "update_device_id"
    case send_message
    case pre_approve
    case updateBookingType = "update_booking_type"
    case room_bed_details = "room_bed_details"
    case listing_rooms_beds = "listing_rooms_beds"
    case update_policy = "update_policy"
    case disable_listing = "disable_listing"
    case accept

    case host_cancel_reservation = "host_cancel_reservation"
    case guest_cancel_reservation = "guest_cancel_reservation"
    case update_location = "update_location"
    case update_Long_term_prices
    case update_price_rule
    case delete_price_rule
    case update_availability_rule
    case update_minimum_maximum_stay
    case delete_availability_rule
    
}

extension APIEnums{//Return method for API
    var method : HTTPMethod{
        switch self {
        case .edit_profile:
            return .post
        case .add_payout_perference:
            return .post
            
        case .addStayImage:
            return .post
        default:
            return .get
        }
    }

    var cacheAttribute: Bool{
        switch self {
        case .language_content,.login:
            return true
        default:
            return false
        }
    }
}
