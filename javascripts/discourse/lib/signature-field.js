import { get } from "@ember/object";

export function signatureFieldKey() {
  const id = String(settings.signature_user_field_id || "").trim();

  if (!id) {
    return null;
  }

  return id.startsWith("user_field_") ? id : `user_field_${id}`;
}

export function getSignatureValue(user) {
  const fieldKey = signatureFieldKey();

  if (!fieldKey || !user) {
    return null;
  }

  const value = get(user.custom_fields, fieldKey);
  return value ? String(value).trim() : null;
}
