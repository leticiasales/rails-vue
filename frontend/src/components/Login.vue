<template>
 <div>
   <form class="login" @submit.prevent="login">
    <h1>Sign in</h1>
    <md-card-content>
      <div class="md-layout md-gutter">
        <div class="md-layout-item md-small-size-100">
          <md-field>
            <label for="username">Username</label>
            <md-input name="username" id="username" autocomplete="given-name" v-model="username"/>
          </md-field>
          <md-field>
            <label for="password">Password</label>
            <md-input v-model="password" name="password" type="password" placeholder="Password"></md-input>
          </md-field>
        </div>
      </div>
      <md-card-actions>
        <md-button type="submit" class="md-primary">
          Login
        </md-button>
      </md-card-actions>
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
       .catch(err => { console.log(err); })
      }
    }

  }
</script>