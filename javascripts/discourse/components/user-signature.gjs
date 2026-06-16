import Component from "@glimmer/component";
import { service } from "@ember/service";
import getURL from "discourse/lib/get-url";
import { eq } from "discourse/truth-helpers";
import dIcon from "discourse/ui-kit/helpers/d-icon";
import { themePrefix } from "virtual:theme";
import { i18n } from "discourse-i18n";
import { getSignatureValue, signatureFieldKey } from "../lib/signature-field";

export default class UserSignature extends Component {
  @service currentUser;

  get signature() {
    return getSignatureValue(this.args.user);
  }

  get displayType() {
    return this.args.displayType || settings.signature_display || "block";
  }

  get fieldKey() {
    return signatureFieldKey();
  }

  get isOwnUser() {
    return this.currentUser?.id === this.args.user?.id;
  }

  get showEditLink() {
    return settings.show_edit_link && this.isOwnUser;
  }

  get editProfileUrl() {
    return getURL(`/u/${this.currentUser.username}/preferences/profile`);
  }

  <template>
    {{#if this.signature}}
      {{#if (eq this.displayType "block")}}
        <div
          class="user-signature user-signature-block field-{{this.fieldKey}}"
        >
          <span class="user-signature-text">{{this.signature}}</span>

          {{#if this.showEditLink}}
            <a
              href={{this.editProfileUrl}}
              class="user-signature-edit"
              title={{i18n (themePrefix "user_signature.edit")}}
            >
              {{dIcon "pencil"}}
            </a>
          {{/if}}
        </div>
      {{else}}
        <span
          class="user-signature user-signature-inline field-{{this.fieldKey}}"
        >
          <span class="user-signature-text">{{this.signature}}</span>

          {{#if this.showEditLink}}
            <a
              href={{this.editProfileUrl}}
              class="user-signature-edit"
              title={{i18n (themePrefix "user_signature.edit")}}
            >
              {{dIcon "pencil"}}
            </a>
          {{/if}}
        </span>
      {{/if}}
    {{/if}}
  </template>
}
