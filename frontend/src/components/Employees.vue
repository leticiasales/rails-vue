<template>
  <div id="app" class="columns">
    <div class="column">
      <!-- <employee-component v-for="employee in employees" :employee="employee"/> -->
      <ul>
         <li v-for="employee in employees" v-bind:key="employee">{{ employee.name }}</li>
      </ul>
    </div>
  </div>
</template>


<script>
  export default {
    data(){
      return {
        employees: []
      }
    },
    mounted: function() {
      this.$store.dispatch('get_employees')
       .then((response) => this.employees = response.data)
       .catch(err => { console.log(err); })
    }
  }
</script>