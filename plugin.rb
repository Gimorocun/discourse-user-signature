# frozen_string_literal: true

# name: discourse-user-signature
# about: Exposes public user custom fields on the About page for user signatures.
# version: 1.0.0
# authors: Iryuu

after_initialize do
  AboutSerializer::UserAboutSerializer.class_eval do
    attributes :custom_fields

    def custom_fields
      fields = User.allowed_user_custom_fields(scope)

      if fields.blank?
        {}
      elsif object.custom_fields_preloaded?
        {}.tap { |h| fields.each { |f| h[f] = object.custom_fields[f] } }
      else
        User.custom_fields_for_ids([object.id], fields)[object.id] || {}
      end
    end
  end
end
