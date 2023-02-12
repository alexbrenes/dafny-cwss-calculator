
method TechnicalImpact(technicalImpact: real) returns (TI: real)
    requires technicalImpact >= 0.0;

    ensures technicalImpact == 0.0 ==> TI == 0.0;
    ensures technicalImpact != 0.0 ==> TI == 1.0;
{
    if (technicalImpact == 0.0)
    {
        TI := 0.0;
    }
    else
    {
        TI := 1.0;
    }
    assert TI == 0.0 || TI == 1.0;
    return TI;
}

method BusinessImpact(businessImpact: real) returns (BI: real)
    requires businessImpact >= 0.0;

    ensures businessImpact == 0.0 ==> BI == 0.0;
    ensures businessImpact != 0.0 ==> BI == 1.0;
{
    if (businessImpact == 0.0)
    {
        BI := 0.0;
    }
    else
    {
        BI := 1.0;
    }
    assert BI == 0.0 || BI == 1.0;
    return BI;
}

method BaseFinding(technicalImpact: real, acquiredPrivilege: real, acquiredPrivilegeLayer: real, internalControlEffectiveness: real, findingConfidence: real) returns (baseFinding: real)
    requires 0.0 <= technicalImpact && technicalImpact <= 1.0;
    requires 0.0 < acquiredPrivilege && acquiredPrivilege <= 1.0;
    requires 0.0 < acquiredPrivilegeLayer && acquiredPrivilegeLayer <= 1.0;
    requires 0.0 <= internalControlEffectiveness && internalControlEffectiveness <= 1.0;
    requires 0.0 <= findingConfidence && findingConfidence <= 1.0;

    ensures 0.0 <= baseFinding;
{
    var TI := TechnicalImpact(technicalImpact);
    baseFinding := ((10.0 * technicalImpact + 5.0 * (acquiredPrivilege + acquiredPrivilegeLayer) + 5.0 * findingConfidence) * TI * internalControlEffectiveness) * 4.0;
    assert baseFinding >= 0.0;
    return baseFinding;
}

method  AttackSurface(requiredPrivilege: real,requiredPrivilegeLayer: real,accessVector: real,authenticationStrength: real,levelInteraction: real,deploymentScope: real) returns (attackSurface: real)
    requires 0.0 < requiredPrivilege && requiredPrivilege <= 1.0;
    requires 0.0 < requiredPrivilegeLayer && requiredPrivilegeLayer <= 1.0;
    requires 0.0 < accessVector && accessVector <= 1.0;
    requires 0.0 < authenticationStrength && authenticationStrength <= 1.0;
    requires 0.0 <= levelInteraction && levelInteraction <= 1.0;
    requires 0.0 < deploymentScope && deploymentScope <= 1.0;

    ensures 0.0 <= attackSurface && attackSurface <= 1.0;
{
    attackSurface := (20.0 * (requiredPrivilege + requiredPrivilegeLayer + accessVector) + 20.0*deploymentScope + 15.0*levelInteraction + 5.0*authenticationStrength ) / 100.0;
    assert attackSurface >= 0.0;
    assert attackSurface <= 1.0;
    return attackSurface;
}

method  Environmental(businessImpact: real,likelihoodOfDiscovery: real,likelihoodOfExploit: real,externalControlEffectiveness: real,prevalence: real) returns (environmental: real)
    requires 0.0 <= businessImpact && businessImpact <= 1.0;
    requires 0.0 < likelihoodOfDiscovery && likelihoodOfDiscovery <= 1.0;
    requires 0.0 <= likelihoodOfExploit && likelihoodOfExploit <= 1.0;
    requires 0.0 < externalControlEffectiveness && externalControlEffectiveness <= 1.0;
    requires 0.0 < prevalence && prevalence <= 1.0;

    ensures 0.0 <= environmental;
{
    var BI := BusinessImpact(businessImpact);
    assert BI == 0.0 || BI == 1.0;
    environmental := ((10.0*businessImpact + 3.0*likelihoodOfDiscovery + 4.0*likelihoodOfExploit + 3.0*prevalence) * BI * externalControlEffectiveness ) / 20.0;
    return environmental;
}

method CWSS(TI:real,AP:real,AL:real,IC:real,FC:real,RP:real,RL:real,AV:real,AS:real,IN:real,SC:real,BI:real,DI:real,EX:real,EC:real,P:real) returns (cwss:real)
    requires 0.0 <= TI && TI <= 1.0;
    requires 0.0 < AP && AP <= 1.0;
    requires 0.0 < AL && AL <= 1.0;
    requires 0.0 <= IC && IC <= 1.0;
    requires 0.0 <= FC && FC <= 1.0;

    requires 0.0 < RP && RP <= 1.0;
    requires 0.0 < RL && RL <= 1.0;
    requires 0.0 < AV && AV <= 1.0;
    requires 0.0 < AS && AS <= 1.0;
    requires 0.0 <= IN && IN <= 1.0;
    requires 0.0 < SC && SC <= 1.0;

    requires 0.0 <= BI && BI <= 1.0;
    requires 0.0 < DI && DI <= 1.0;
    requires 0.0 <= EX && EX <= 1.0;
    requires 0.0 < EC && EC <= 1.0;
    requires 0.0 < P && P <= 1.0;

    ensures 0.0 <= cwss;
{
    var baseFinding := BaseFinding(TI, AP, AL, IC, FC);
    assert baseFinding >= 0.0;
    var attackSurface := AttackSurface(RP, RL, AV, AS, IN, SC);
    assert attackSurface >= 0.0;
    var environmental := Environmental(BI, DI, EX, EC, P);
    assert environmental >= 0.0;
    cwss := baseFinding * attackSurface * environmental;
    assert cwss >= 0.0;
    return cwss;
}

method Main()
{
    var cwss := CWSS(0.9, 1.0, 1.0, 1.0, 1.0, 0.9, 1.0, 1.0, 1.0, 0.9, 1.0, 0.9, 1.0, 1.0, 1.0, 1.0);
    assert cwss >= 0.0;
    print cwss;
}