<template>
  <div>
    <md-card v-for="employee in employees" v-bind:key="employee.id">
      <md-card-header>
        <div class="md-title">{{ employee.name }}</div>
      </md-card-header>

      <md-card-content>
        <p><span class="bold">Salary: </span>{{employee.salary}}</p>
        <p><span class="bold">Position: </span>{{employee.position_id}}</p>
      </md-card-content>

      <md-card-actions>
        <router-link :to="{name: 'employee_id', params: { id: employee.id }}">
          <md-button>View</md-button>
        </router-link>
        <router-link :to="{name: 'employee_edit', params: { id: employee.id }}">
          <md-button>Edit</md-button>
        </router-link>
      </md-card-actions>
    </md-card>
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