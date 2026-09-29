/* lmac_if__build_cmd_rings @ 0x8f11b4, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_init
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, mem_pool__init, memset0_words, ring__init_desc
 */
	.section .text.lmac_if__build_cmd_rings,"ax",@progbits
	.global lmac_if__build_cmd_rings
lmac_if__build_cmd_rings:
	.global L_8f11b4
L_8f11b4:
	push_s blink
L_8f11b6:
	bl.d L_8c02b4
L_8f11ba:
	mov_s r1,0x60
L_8f11bc:
	mov_s r16,r0
L_8f11be:
	mov r18,0xa0
L_8f11c2:
	mov_s r14,0x84008c
L_8f11c8:
	add r15,r14,0x28
L_8f11cc:
	mov_s r0,0x8802bc
L_8f11d2:
	st_s r15,[r0,0x24]
L_8f11d4:
	add3 r13,r14,0x1d
L_8f11d8:
	st_s r13,[r14,0x28]
L_8f11da:
	st_s r13,[r14,0x30]
L_8f11dc:
	st_s r13,[r14,0x34]
L_8f11de:
	stw_s r1,[r14,0x2e]
L_8f11e0:
	mov_s r0,0x64
L_8f11e2:
	stw_s r0,[r14,0x2c]
L_8f11e4:
	bl.d L_8c1a78
L_8f11e8:
	add3 r0,r14,0x1d
L_8f11ec:
	mov r17,0x8416d4
L_8f11f4:
	mov_s r0,r17
L_8f11f6:
	bl.d L_8c1a78
L_8f11fa:
	mov r1,0x4b0
L_8f11fe:
	add r0,r14,0x14
L_8f1202:
	mov_s r1,r17
L_8f1204:
	mov_s r2,0x64
L_8f1206:
	bl.d L_8c6c70
L_8f120a:
	mov_s r3,0xc
L_8f120c:
	add r0,r16,0x24
L_8f1210:
	mov_s r1,r13
L_8f1212:
	mov_s r2,0x60
L_8f1214:
	mov_s r3,r15
L_8f1216:
	add r4,r14,0x14
L_8f121a:
	mov r5,0x1
L_8f121e:
	bl.d L_8d5898
L_8f1222:
	mov r6,r5
L_8f1226:
	add3 r13,r14,0x9
L_8f122a:
	st_s r13,[r14,0x38]
L_8f122c:
	st_s r13,[r14,0x40]
L_8f122e:
	st_s r13,[r14,0x44]
L_8f1230:
	stw r18,[r14, 0x3e]
L_8f1234:
	mov r15,0x100
L_8f1238:
	stw_s r15,[r14,0x3c]
L_8f123a:
	add3 r0,r14,0x9
L_8f123e:
	bl.d L_8c1a78
L_8f1242:
	mov_s r1,0xa0
L_8f1244:
	mov r17,0x8401d4
L_8f124c:
	mov_s r0,r17
L_8f124e:
	mov_s r1,0x15
L_8f1250:
	bl.d L_8c1a78
L_8f1254:
	asl_s r1,r1,0x8
L_8f1256:
	mov_s r0,r14
L_8f1258:
	mov_s r1,r17
L_8f125a:
	mov_s r2,r15
L_8f125c:
	bl.d L_8c6c70
L_8f1260:
	mov_s r3,0x15
L_8f1262:
	add r0,r16,0x4
L_8f1266:
	mov_s r1,r13
L_8f1268:
	mov_s r2,0xa0
L_8f126a:
	add r3,r14,0x38
L_8f126e:
	mov_s r4,r14
L_8f1270:
	mov r5,0x1
L_8f1274:
	bl.d L_8d5898
L_8f1278:
	mov r6,r5
L_8f127c:
	b L_8c0314
