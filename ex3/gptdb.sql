CREATE TABLE Course (
    cid VARCHAR(255) PRIMARY KEY,
    department VARCHAR(255)
);
CREATE TABLE Prerequisites (
    cid VARCHAR(255),
    preid VARCHAR(255),
    PRIMARY KEY (cid, preid),
    FOREIGN KEY (cid) REFERENCES Course(cid),
    FOREIGN KEY (preid) REFERENCES Course(cid)
);
-- add more insert commands here to derive a minimal example demonstrating that the query is incorrect
INSERT INTO Course(cid, department) VALUES ('1', 'Computer Science');
INSERT INTO Course(cid, department) VALUES ('2', 'Computer Science');
INSERT INTO Course(cid, department) VALUES ('3', 'Computer Science');
INSERT INTO Prerequisites(cid, preid) VALUES (1, 3);
INSERT INTO Prerequisites(cid, preid) VALUES (1, 2);
INSERT INTO Prerequisites(cid, preid) VALUES (2, 3);
INSERT INTO Prerequisites(cid, preid) VALUES (2, 2);
