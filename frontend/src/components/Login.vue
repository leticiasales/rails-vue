<template>
 <div>
   <form class="login" @submit.prevent="login">
    <h1>Sign in</h1>
    <md-card-content>
      <div class="md-layout md-gutter">
        <div class="md-layout-item md-small-size-100">
          <md-field>
            <label for="username">username</label>
            <md-input name="username" id="username" autocomplete="given-name" v-model="form.username" :disabled="sending" />
            <span class="md-error" v-if="!$v.form.username.required">The username is required</span>
            <span class="md-error" v-else-if="!$v.form.username.minlength">Invalid username</span>
          </md-field>
          <md-field>
            <label>Password toggle</label>
            <md-input v-model="password" type="password" placeholder="Password"></md-input>
          </md-field>
        </div>
      </div>
    </md-card-content>
  </form>
</div>
</template>

<script>
  export default {
    data(){
      return {
        username : "",
        password : ""
      }
    },
    methods: {
      login: function () {
        let username = this.username 
        let password = this.password
        this.$store.dispatch('login', { username, password })
       .then(() => this.$router.push('/'))
       .catch(err => { /* eslint-disable no-console */
                    console.log(err);
                      /* eslint-enable no-console */
                    })
      }
    }

  }
</script>