import Component from "@glimmer/component";
import { service } from "@ember/service";
import getURL from "discourse/lib/get-url";
import dIcon from "discourse/ui-kit/helpers/d-icon";
import { themePrefix } from "virtual:theme";
import { i18n } from "discourse-i18n";
import { getSignatureValue, signatureFieldKey } from "../lib/signature-field";

export default class UserSignaturePoster extends Component {
  @service currentUser;

  get signature() {
    return getSignatureValue(this.args.post.user);
  }

  get displayType() {
    return settings.signature_display || "block";
  }

  get fieldKey() {
    return signatureFieldKey();
  }

  get isOwnPost() {
    return this.currentUser?.id === this.args.post.user_id;
  }

  get showEditLink() {
    return settings.show_edit_link && this.isOwnPost;
  }

  get editProfileUrl() {
    return getURL(`/u/${this.currentUser.username}/preferences/profile`);
  }

  <template>
    <div
      class="user-signature user-signature-{{this.displayType}} field-{{this.fieldKey}}"
    >
      {{#if this.signature}}
        <span class="user-signature-text">{{this.signature}}</span>
      {{else if this.isOwnPost}}
        <span class="user-signature-text user-signature-empty">
          {{i18n (themePrefix "user_signature.empty")}}
        </span>
      {{/if}}

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
  </template>
}
