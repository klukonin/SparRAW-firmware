/* wmi_ut_handler @ 0x8ed038, 356 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI_UT_HANDLER:: module_id=0x%x, ut_subtype_id=0x%x
 *   [NNL] parameters: place_holder[0]=0x%x, place_holder[1]=0x%x, place_holder[2]=0x%x,
 *   [NNL] place_holder[3]=0x%x, place_holder[4]=0x%x, place_holder[5]=0x%x
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: UT_HW_DRIVERS_cmd_handler, UT_HW_FLOWS_OPERATIONAL_cmd_handler, UT_HW_MODES_cmd_handler, UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler, __ld_r16_to_r13_ret, __st_r16_to_r13, calib_mgr_ut, calib_req__fill, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, power_mgr_ut
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_ut_handler
wmi_ut_handler:
	.global L_8ed038
L_8ed038:
	push_s blink
L_8ed03a:
	bl L_8c01dc
L_8ed03e:
	mov_s r16,r0
L_8ed040:
	mov_s r13,r1
L_8ed042:
	ldw_s r2,[r13]
L_8ed044:
	mov_s r1,0x1008dcc
L_8ed04a:
	mov_s r0,0x20
L_8ed04c:
	bl.d L_8dcc80
L_8ed050:
	ldw_s r3,[r13,0x2]
L_8ed052:
	mov_s r1,0x1008e00
L_8ed058:
	ld r4,[r13, 0xc]
L_8ed05c:
	mov_s r0,0x20
L_8ed05e:
	ld_s r2,[r13,0x4]
L_8ed060:
	bl.d L_8dcd00
L_8ed064:
	ld_s r3,[r13,0x8]
L_8ed066:
	mov_s r1,0x1008e54
L_8ed06c:
	ld r4,[r13, 0x18]
L_8ed070:
	mov_s r0,0x20
L_8ed072:
	ld_s r2,[r13,0x10]
L_8ed074:
	bl.d L_8dcd00
L_8ed078:
	ld_s r3,[r13,0x14]
L_8ed07a:
	ldw_s r0,[r13]
L_8ed07c:
	/* sub_s r0,r0,0x7 */
	.byte 0x67,0xb8
L_8ed07e:
	brhs r0,0x7,L_8ed0ca
L_8ed082:
	ldb.x r0,[0x8021e0,r0]
L_8ed08a:
	add r1,pcl,0xa
L_8ed08e:
	add1_s r1,r1,r0
L_8ed090:
	j_s [r1]
L_8ed092:
	bl.d L_8eadb8
L_8ed096:
	mov_s r0,r13
L_8ed098:
	b_s L_8ed0d4
L_8ed09a:
	mov_s r0,r16
L_8ed09c:
	bl.d L_8fa884
L_8ed0a0:
	mov_s r1,r13
L_8ed0a2:
	b_s L_8ed0d4
L_8ed0a4:
	mov_s r0,r16
L_8ed0a6:
	bl.d L_8faf34
L_8ed0aa:
	mov_s r1,r13
L_8ed0ac:
	b_s L_8ed0d4
L_8ed0ae:
	mov_s r0,r16
L_8ed0b0:
	bl.d L_8fada4
L_8ed0b4:
	mov_s r1,r13
L_8ed0b6:
	b_s L_8ed0d4
L_8ed0b8:
	mov_s r0,r16
L_8ed0ba:
	bl.d L_8eaec8
L_8ed0be:
	mov_s r1,r13
L_8ed0c0:
	b_s L_8ed0d4
L_8ed0c2:
	bl.d L_8eae14
L_8ed0c6:
	mov_s r0,r13
L_8ed0c8:
	b_s L_8ed0d4
	.global L_8ed0ca
L_8ed0ca:
	mov_s r0,blink
L_8ed0cc:
	mov_s r1,0xcf
L_8ed0ce:
	bl.d L_8c9b28
L_8ed0d2:
	bset_s r1,r1,0xc
	.global L_8ed0d4
L_8ed0d4:
	b L_8c0244
L_8ed0d8:
	ldb r0,[0x8005c1]
L_8ed0e0:
	sub.f r0,r0,0x1
L_8ed0e4:
	beq L_8ed150
L_8ed0e8:
	lr r0,[0x7b]
L_8ed0ec:
	and r1,r0,0xff
L_8ed0f4:
	sub.f 0x0,r1,0x1
L_8ed0f8:
	beq L_8ed120
L_8ed0fc:
	sub.f 0x0,r1,0x4
L_8ed100:
	beq L_8ed120
L_8ed104:
	flag 0x1
L_8ed108:
	mov 0x0,0x0
L_8ed10c:
	mov 0x0,0x0
L_8ed110:
	mov 0x0,0x0
L_8ed114:
	mov 0x0,0x0
L_8ed118:
	mov 0x0,0x0
L_8ed11c:
	mov 0x0,0x0
	.global L_8ed120
L_8ed120:
	lr r0,[0x7d]
L_8ed124:
	and r1,r0,0xff
L_8ed12c:
	sub.f 0x0,r1,0x0
L_8ed130:
	bne L_8ed150
L_8ed134:
	flag 0x1
L_8ed138:
	mov 0x0,0x0
L_8ed13c:
	mov 0x0,0x0
L_8ed140:
	mov 0x0,0x0
L_8ed144:
	mov 0x0,0x0
L_8ed148:
	mov 0x0,0x0
L_8ed14c:
	mov 0x0,0x0
	.global L_8ed150
L_8ed150:
	j [blink]
L_8ed154:
	add_s r0,r0,0x38
L_8ed156:
	b.d L_8c1838
L_8ed15a:
	mov_s r1,0x0
L_8ed15c:
	push_s r13
L_8ed15e:
	mov_s r13,0xff
L_8ed160:
	stb r13,[r0, 0x30]
L_8ed164:
	mov_s r2,0x0
L_8ed166:
	st_s r2,[r0,0x34]
L_8ed168:
	mov_s r1,0x8008c4
L_8ed16e:
	st_s r1,[r0,0x2c]
L_8ed170:
	add2 r3,r0,0x15
L_8ed174:
	stb r13,[r3, 0x30]
L_8ed178:
	st_s r2,[r3,0x34]
L_8ed17a:
	mov_s r1,0x80075c
L_8ed180:
	st_s r1,[r3,0x2c]
L_8ed182:
	stb.a r13,[r0,0x98]
L_8ed186:
	st_s r2,[r0,0x4]
L_8ed188:
	st_s r2,[r0,0x8]
L_8ed18a:
	j_s.d [blink]
L_8ed18c:
	pop_s r13
L_8ed18e:
	nop_s
L_8ed190:
	mov_s r1,0x800888
L_8ed196:
	j_s.d [blink]
L_8ed198:
	st_s r1,[r0,0x68]
L_8ed19a:
	nop_s
