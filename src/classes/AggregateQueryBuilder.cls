/******************************************************************************************************
* This file is part of the Nebula Query & Search project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/jongpie/NebulaQueryAndSearch for full license details. *
******************************************************************************************************/
public class AggregateQueryBuilder extends Soql {

    private enum Aggregate { AVG, COUNT, COUNT_DISTINCT, MAX, MIN, SUM }

    private List<AggregateField> aggregateFields;

    public AggregateQueryBuilder(Schema.SobjectType sobjectType) {
        super(sobjectType);

        this.aggregateFields = new List<AggregateField>();
        this.sortQueryFields = false;
    }

    public AggregateQueryBuilder groupBy(Schema.SobjectField field) {
       return this.groupBy(new Soql.QueryField(field));
    }

    public AggregateQueryBuilder groupBy(Soql.QueryField queryField) {
        return this.groupBy(new List<Soql.QueryField>{queryField});
    }

    public AggregateQueryBuilder groupBy(Schema.FieldSet fieldSet) {
        List<Soql.QueryField> queryFields = new List<Soql.QueryField>();
        for(Schema.FieldSetMember fieldSetMember : fieldSet.getFields()) {
            queryFields.add(new Soql.QueryField(this.sobjectType, fieldSetMember.getFieldPath()));
        }
        return this.groupBy(queryFields);
    }

    public AggregateQueryBuilder groupBy(List<Schema.SobjectField> fields) {
        List<Soql.QueryField> queryFields = new List<Soql.QueryField>();
        for(Schema.SobjectField field : fields) {
            queryFields.add(new Soql.QueryField(field));
        }
        return this.groupBy(queryFields);
    }

    public AggregateQueryBuilder groupBy(List<Soql.QueryField> queryFields) {
        super.doAddFields(queryFields, null);
        return this.setHasChanged();
    }

    public AggregateQueryBuilder avg(Schema.SobjectField numericField) {
        return this.avg(new Soql.QueryField(numericField));
    }

    public AggregateQueryBuilder avg(Soql.QueryField numericQueryField) {
        return this.avg(numericQueryField, null);
    }

    public AggregateQueryBuilder avg(Soql.QueryField numericQueryField, String fieldAlias) {
        return this.buildAggregateFunction(numericQueryField, Aggregate.AVG, fieldAlias);
    }

    public AggregateQueryBuilder count(Schema.SobjectField field) {
        return this.count((new Soql.QueryField(field)), null);
    }

    public AggregateQueryBuilder count(Soql.QueryField queryField) {
        return this.count(queryField, null);
    }

    public AggregateQueryBuilder count(Soql.QueryField queryField, String fieldAlias) {
        return this.buildAggregateFunction(queryField, Aggregate.COUNT, fieldAlias);
    }

    public AggregateQueryBuilder countDistinct(Schema.SobjectField field) {
        return this.countDistinct(new Soql.QueryField(field), null);
    }

    public AggregateQueryBuilder countDistinct(Soql.QueryField queryField) {
        return this.countDistinct(queryField, null);
    }

    public AggregateQueryBuilder countDistinct(Soql.QueryField queryField, String fieldAlias) {
        return this.buildAggregateFunction(queryField, Aggregate.COUNT_DISTINCT, fieldAlias);
    }

    public AggregateQueryBuilder max(Schema.SobjectField field) {
        return this.max(new Soql.QueryField(field), null);
    }

    public AggregateQueryBuilder max(Soql.QueryField queryField) {
        return this.max(queryField, null);
    }

    public AggregateQueryBuilder max(Soql.QueryField queryField, String fieldAlias) {
        return this.buildAggregateFunction(queryField, Aggregate.MAX, fieldAlias);
    }

    public AggregateQueryBuilder min(Schema.SobjectField field) {
        return this.min(new Soql.QueryField(field), null);
    }

    public AggregateQueryBuilder min(Soql.QueryField queryField) {
        return this.min(queryField, null);
    }

    public AggregateQueryBuilder min(Soql.QueryField queryField, String fieldAlias) {
        return this.buildAggregateFunction(queryField, Aggregate.MIN, fieldAlias);
    }

    public AggregateQueryBuilder sum(Schema.SobjectField numericField) {
        return this.sum(new Soql.QueryField(numericField), null);
    }

    public AggregateQueryBuilder sum(Soql.QueryField numericQueryField) {
        return this.sum(numericQueryField, null);
    }

    public AggregateQueryBuilder sum(Soql.QueryField numericQueryField, String fieldAlias) {
        return this.buildAggregateFunction(numericQueryField, Aggregate.SUM, fieldAlias);
}

    public AggregateQueryBuilder filterWhere(Schema.SobjectField field, String operator, Object value) {
        return this.filterWhere(new Soql.QueryField(field), operator, value);
    }

    public AggregateQueryBuilder filterWhere(Soql.QueryField queryField, String operator, Object value) {
        return this.filterWhere(new Soql.QueryFilter(queryField, operator, value));
    }

    public AggregateQueryBuilder filterWhere(Soql.QueryFilter filter) {
        return this.filterWhere(new List<Soql.QueryFilter>{filter});
    }

    public AggregateQueryBuilder filterWhere(List<Soql.QueryFilter> filters) {
        super.doFilterWhere(filters);
        return this.setHasChanged();
    }

    public AggregateQueryBuilder orderBy(Schema.SobjectField field) {
        return this.orderBy(new Soql.QueryField(field), null, null);
    }

    public AggregateQueryBuilder orderBy(Soql.QueryField queryField) {
        return this.orderBy(queryField, null, null);
    }

    public AggregateQueryBuilder orderBy(Schema.SobjectField field, Soql.SortOrder sortOrder) {
        return this.orderBy(field, sortOrder, null);
    }

    public AggregateQueryBuilder orderBy(Soql.QueryField queryField, Soql.SortOrder sortOrder) {
        return this.orderBy(queryField, sortOrder, null);
    }

    public AggregateQueryBuilder orderBy(Schema.SobjectField field, Soql.SortOrder sortOrder, Boolean sortNullsFirst) {
        return this.orderBy(new Soql.QueryField(field), sortOrder, sortNullsFirst);
    }

    public AggregateQueryBuilder orderBy(Soql.QueryField queryField, Soql.SortOrder sortOrder, Boolean sortNullsFirst) {
        super.doOrderBy(queryField, sortOrder, sortNullsFirst);
        return this.setHasChanged();
    }

    public AggregateQueryBuilder orderBy(Schema.SobjectField field, AggregateQueryBuilder.Aggregate aggregateFunction) {
        return this.orderBy(field, aggregateFunction, null, null);
    }

    public AggregateQueryBuilder orderBy(Schema.SobjectField field, AggregateQueryBuilder.Aggregate aggregateFunction, Soql.SortOrder sortOrder) {
        return this.orderBy(field, aggregateFunction, sortOrder, null);
    }

    public AggregateQueryBuilder orderBy(Schema.SobjectField field, AggregateQueryBuilder.Aggregate aggregateFunction, Soql.SortOrder sortOrder, Boolean sortNullsFirst) {
        super.doOrderBy(aggregateFunction.name() + '(' + field + ')', sortOrder, sortNullsFirst);
        return this.setHasChanged();
    }

    public AggregateQueryBuilder limitTo(Integer numberOfRecords) {
        super.doLimitTo(numberOfRecords);
        return this.setHasChanged();
    }

    public AggregateQueryBuilder offsetBy(Integer offset) {
        super.doOffsetBy(offset);
        return this.setHasChanged();
    }

    public override String getQuery() {
        if(this.query != null && !this.hasChanged) return this.query;

        String queryFieldString = super.doGetQueryFieldString();
        String aggregateQueryFieldString = this.getAggregateQueryFieldString();
        String aggregateFieldDelimiter = !String.isEmpty(queryFieldString) && !String.isEmpty(aggregateQueryFieldString) ? ', ' : '';

        this.query = 'SELECT ' + queryFieldString + aggregateFieldDelimiter + aggregateQueryFieldString
            + ' FROM ' + this.sobjectType
            + super.doGetUsingScopeString()
            + super.doGetWhereClauseString()
            + this.getGroupByString()
            + super.doGetOrderByString()
            + super.doGetLimitCountString()
            + super.doGetOffetString();

        return this.query;
    }

    public AggregateResult getFirstResult() {
        return (AggregateResult)super.doGetFirstResult();
    }

    public List<AggregateResult> getResults() {
        return (List<AggregateResult>)super.doGetResults();
    }

    private AggregateQueryBuilder setHasChanged() {
        this.hasChanged = true;
        return this;
    }

    private AggregateQueryBuilder buildAggregateFunction(Schema.SobjectField field, AggregateQueryBuilder.Aggregate aggregateFunction) {
        return this.buildAggregateFunction(new Soql.QueryField(field), aggregateFunction, null);
    }

    private AggregateQueryBuilder buildAggregateFunction(Soql.QueryField queryField, AggregateQueryBuilder.Aggregate aggregateFunction) {
        return this.buildAggregateFunction(queryField, aggregateFunction, null);
    }

    private AggregateQueryBuilder buildAggregateFunction(Soql.QueryField queryField, AggregateQueryBuilder.Aggregate aggregateFunction, String fieldAlias) {
        this.aggregateFields.add(new AggregateField(queryField, aggregateFunction, fieldAlias));
        return this.setHasChanged();
    }

    private String getAggregateQueryFieldString() {
        if(this.aggregateFields.isEmpty()) return '';

        List<String> aggregateFieldStrings = new List<String>();
        for(AggregateQueryBuilder.AggregateField aggregatedField : this.aggregateFields) {
            aggregateFieldStrings.add(aggregatedField.toString());
        }
        return String.join(aggregateFieldStrings, ', ');
    }

    private String getGroupByString() {
        String queryFieldString = super.doGetQueryFieldString();
        //return String.isEmpty(queryFieldString) || this.aggregateFields.isEmpty() ? '' : ' GROUP BY ' + queryFieldString;
        return String.isEmpty(queryFieldString) ? '' : ' GROUP BY ' + queryFieldString;
    }

    private class AggregateField {

        private String aggregateFieldPath;

        public AggregateField(Soql.QueryField queryField, AggregateQueryBuilder.Aggregate aggregateFunction, String fieldAlias) {
            String fieldApiName    = queryField.getDescribe().getName();
            String queryFieldAlias = !String.isEmpty(fieldAlias) ? fieldAlias : fieldApiName + '__' + aggregateFunction.name();

            // Alias: MIN(Schema.Lead.MyField__c) is auto-aliased to MyField__c__MIN
            this.aggregateFieldPath = aggregateFunction.name() + '(' + fieldApiName + ') ' + fieldAlias;
        }

        public override String toString() {
            return this.aggregateFieldPath;
        }

    }

}