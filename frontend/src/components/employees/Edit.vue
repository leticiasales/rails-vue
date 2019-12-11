<template>
 <div>
  <Form title="Edit Employee" submit="Save" :employee="this.employee">
  </Form>
 </div>
</template>

<script>
// @ is an alias to /src
import Form from './Form.vue';

export default {
  name: 'employee-new',
  components: {
    Form
  },
  data(){
    return {
      employee: {}
    }
  },
  mounted: function() {
    this.$store.dispatch('get_employee_by_id', this.$route.params.id)
     .then((response) => this.employee = response.data)
     .catch(err => { console.log(err); })
  },
  methods: {
    submit: function (employee) {
      this.$store.dispatch('edit_employee', employee)
     .then((response) => this.$router.push('/employees/' + this.data.id))
     .catch(err => console.log(err))
    }
  }
}
</script>
