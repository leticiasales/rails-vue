<template>
  <div id="app" class="columns">
    <div class="column">
      <h1>{{ employee.name }}</h1>
      <h2>{{ employee.salary }}</h2>
    </div>
  </div>
</template>


<script>
  export default {
    data(){
      return {
        employee: {}
      }
    },
    mounted: function() {
      this.$store.dispatch('get_employee', this.$route.params.id)
       .then((response) => this.employee = response.data)
       .catch(err => { console.log(err); })
    }
  }
</script>