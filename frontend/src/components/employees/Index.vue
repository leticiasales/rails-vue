<template>
  <div id="app" class="columns">
    <div class="column">
      <ul>
        <li v-for="employee in employees" v-bind:key="employee.id">
          <router-link :to="{name: 'employee_id', params: {id: employee.id }}">
            {{ employee.name }}
          </router-link>
        </li>
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