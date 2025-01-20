<#import "template.ftl" as layout>
<@layout.registrationLayout 
    displayMessage=!messagesPerField.existsError('username','password') 
    displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; 
    section
>
    <#if section = "header">
        <h1 class="login-title">${msg("loginAccountTitle")}</h1>
    <#elseif section = "form">
    <div id="kc-form" class="login-form-container">
      <div id="kc-form-wrapper" class="login-form-wrapper">
        <#if realm.password>
            <form id="kc-form-login" 
                  class="login-form"
                  onsubmit="document.getElementById('kc-login').disabled = true; return true;" 
                  action="${url.loginAction}" 
                  method="post"
                  novalidate>
                
                <#if !usernameHidden??>
                    <div class="form-group ${properties.kcFormGroupClass!}">
                        <label for="username" 
                               class="form-label ${properties.kcLabelClass!}">
                            <#if !realm.loginWithEmailAllowed>
                                ${msg("username")}
                            <#elseif !realm.registrationEmailAsUsername>
                                ${msg("usernameOrEmail")}
                            <#else>
                                ${msg("email")}
                            </#if>
                        </label>

                        <input tabindex="1" 
                               id="username" 
                               class="form-input ${properties.kcInputClass!}"
                               name="username" 
                               value="${(login.username!'')}"
                               type="text" 
                               autofocus 
                               autocomplete="username"
                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                               required
                        />

                        <#if messagesPerField.existsError('username','password')>
                            <div id="username-error" 
                                 class="error-message ${properties.kcInputErrorMessageClass!}" 
                                 aria-live="polite">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </div>
                        </#if>
                    </div>
                </#if>

                <div class="form-group ${properties.kcFormGroupClass!}">
                    <label for="password" 
                           class="form-label ${properties.kcLabelClass!}">
                        ${msg("password")}
                    </label>

                    <div class="password-input-wrapper">
                        <input tabindex="2" 
                               id="password" 
                               class="form-input ${properties.kcInputClass!}"
                               name="password" 
                               type="password" 
                               autocomplete="current-password"
                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                               required
                        />
                        <button type="button" 
                                class="password-toggle" 
                                aria-label="Toggle password visibility"
                                onclick="togglePassword()">
                            <i class="eye-icon"></i>
                        </button>
                    </div>

                    <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                        <div id="password-error" 
                             class="error-message ${properties.kcInputErrorMessageClass!}" 
                             aria-live="polite">
                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                        </div>
                    </#if>
                </div>

                <div class="form-options ${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                    <div class="remember-me">
                        <#if realm.rememberMe && !usernameHidden??>
                            <label class="checkbox-label">
                                <input tabindex="3" 
                                       id="rememberMe" 
                                       name="rememberMe" 
                                       type="checkbox"
                                       <#if login.rememberMe??>checked</#if>
                                />
                                <span class="checkbox-text">${msg("rememberMe")}</span>
                            </label>
                        </#if>
                    </div>
                    
                    <div class="forgot-password ${properties.kcFormOptionsWrapperClass!}">
                        <#if realm.resetPasswordAllowed>
                            <a tabindex="5" 
                               href="${url.loginResetCredentialsUrl}"
                               class="forgot-password-link">
                                ${msg("doForgotPassword")}
                            </a>
                        </#if>
                    </div>
                </div>

                <div class="form-actions">
                    <input type="hidden" 
                           id="id-hidden-input" 
                           name="credentialId" 
                           <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>
                    />
                    <button tabindex="4" 
                            class="submit-button"
                            name="login" 
                            id="kc-login" 
                            type="submit">
                        ${msg("doLogIn")}
                    </button>
                </div>
            </form>
        </#if>
        </div>
    </div>

    <#elseif section = "info">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div class="registration-container">
                <p class="registration-text">
                    ${msg("noAccount")} 
                    <a tabindex="6" 
                       href="${url.registrationUrl}"
                       class="register-link">
                        ${msg("doRegister")}
                    </a>
                </p>
            </div>
        </#if>
    <#elseif section = "socialProviders">
        <#if realm.password && social.providers??>
            <div class="social-providers">
                <div class="divider">
                    <span class="divider-text">${msg("or")}</span>
                </div>

                <ul class="social-providers-list">
                    <#list social.providers as p>
                        <li class="social-provider-item">
                            <a href="${p.loginUrl}" 
                               id="social-${p.alias}"
                               class="social-provider-link"
                               aria-label="${msg("loginWith")} ${p.displayName!}">
                                <#if p.iconClasses?has_content>
                                    <i class="provider-icon ${p.iconClasses!}" aria-hidden="true"></i>
                                    <span class="provider-name">${p.displayName!}</span>
                                <#else>
                                    <span class="provider-name">${p.displayName!}</span>
                                </#if>
                            </a>
                        </li>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>

<style>
    .login-form-container {
        max-width: 400px;
        margin: 0 auto;
        padding: 2rem;
    }

    .form-group {
        margin-bottom: 1.5rem;
    }

    .form-label {
        display: block;
        margin-bottom: 0.5rem;
        font-size: 0.875rem;
        font-weight: 500;
    }

    .form-input {
        width: 100%;
        padding: 0.75rem;
        border: 1px solid #e2e8f0;
        border-radius: 0.375rem;
        transition: border-color 0.15s ease-in-out;
    }

    .form-input:focus {
        outline: none;
        border-color: #001259;
        box-shadow: 0 0 0 3px rgba(0, 18, 89, 0.1);
    }

    .error-message {
        color: #dc2626;
        font-size: 0.875rem;
        margin-top: 0.5rem;
    }

    .submit-button {
        width: 100%;
        padding: 0.75rem;
        background-color: #001259;
        color: white;
        border: none;
        border-radius: 0.375rem;
        font-weight: 500;
        cursor: pointer;
        transition: background-color 0.15s ease-in-out;
    }

    .submit-button:hover {
        background-color: #000c3d;
    }

    .submit-button:disabled {
        opacity: 0.5;
        cursor: not-allowed;
    }

    /* Add more custom styles as needed */
</style>

<script>
    function togglePassword() {
        const passwordInput = document.getElementById('password');
        const type = passwordInput.type === 'password' ? 'text' : 'password';
        passwordInput.type = type;
    }
</script>
