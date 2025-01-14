<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>

<#if user.username == user.email>
    <#if user.attributes.name?has_content>
        <#assign username = user.attributes.name>
    <#else>
        <#assign username = ''>
    </#if>
<#else>
    <#assign username = user.username>
</#if>


<@layout.registrationLayout
  displayMessage=!messagesPerField.existsError("email", "firstName", "lastName", "username")
  ;
  section
>
  <#if section="header">
    ${msg("loginProfileTitle")}
  <#elseif section="form">
    <@form.kw action=url.loginAction method="post">

      <@input.kw
        autocomplete="email"
        invalid=messagesPerField.existsError("email")
        label=msg("email")
        message=kcSanitize(messagesPerField.get("email"))
        name="email"
        type="email"
        value=(user.email)!''
      />
      <#if user.editUsernameAllowed>
          <@input.kw
          autocomplete="username"
          autofocus=true
          invalid=messagesPerField.existsError("username")
          label=msg("username")
          message=kcSanitize(messagesPerField.get("username"))
          name="username"
          type="text"
          value=(username)
          />
      </#if>
<#--      <@input.kw-->
<#--        autocomplete="given-name"-->
<#--        invalid=messagesPerField.existsError("nickName")-->
<#--        label=msg("nickName")-->
<#--        message=kcSanitize(messagesPerField.get("nickName"))-->
<#--        name="user.attributes.name"-->
<#--        type="text"-->
<#--        value=((user.attributes.name)!(user.firstName))!''-->
<#--        />-->
<#--      <@input.kw-->
<#--        autocomplete="given-name"-->
<#--        invalid=messagesPerField.existsError("firstName")-->
<#--        label=msg("firstName")-->
<#--        message=kcSanitize(messagesPerField.get("firstName"))-->
<#--        name="firstName"-->
<#--        type="text"-->
<#--        value=(user.firstName)!''-->
<#--      />-->
<#--      <@input.kw-->
<#--        autocomplete="family-name"-->
<#--        invalid=messagesPerField.existsError("lastName")-->
<#--        label=msg("lastName")-->
<#--        message=kcSanitize(messagesPerField.get("lastName"))-->
<#--        name="lastName"-->
<#--        type="text"-->
<#--        value=(user.lastName)!''-->
<#--      />-->
      <@buttonGroup.kw>
        <#if isAppInitiatedAction??>
          <@button.kw color="primary" type="submit">
            ${msg("doSubmit")}
          </@button.kw>
          <@button.kw color="secondary" name="cancel-aia" type="submit" value="true">
            ${msg("doCancel")}
          </@button.kw>
        <#else>
          <@button.kw color="primary" type="submit">
            ${msg("doSubmit")}
          </@button.kw>
        </#if>
      </@buttonGroup.kw>
    </@form.kw>
  </#if>
</@layout.registrationLayout>
<script type="text/javascript">
  const username = "${username}";
  const email = "${user.email}";


  if(username && email && username !== email){
    <#if !messagesPerField.existsError("username") && !messagesPerField.existsError("email")>
      document.querySelector("button[type='submit']").click();
    </#if>
  }

</script>
